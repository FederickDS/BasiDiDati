-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Vasca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Vasca` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Vasca` (
  `nome` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Corso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Corso` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Corso` (
  `CorsoID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `minimo` INT UNSIGNED NOT NULL,
  `stato` ENUM('C', 'P', 'A') NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `costo` INT UNSIGNED NOT NULL,
  `num_iscritti` INT UNSIGNED NOT NULL DEFAULT 0,
  `data_inizio` TIMESTAMP NOT NULL,
  `data_fine` TIMESTAMP NOT NULL,
  `capienza` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`CorsoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appuntamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Appuntamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Appuntamento` (
  `Corso` INT UNSIGNED NOT NULL,
  `inizio` TIMESTAMP NOT NULL,
  `fine` TIMESTAMP NOT NULL,
  `Vasca` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Corso`, `inizio`),
  INDEX `Vasca_idx` (`Vasca` ASC) VISIBLE,
  INDEX `Intervallo_idx` (`inizio` ASC, `fine` ASC) VISIBLE,
  CONSTRAINT `fk_corso_appuntamento`
    FOREIGN KEY (`Corso`)
    REFERENCES `mydb`.`Corso` (`CorsoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vasca_appuntamento`
    FOREIGN KEY (`Vasca`)
    REFERENCES `mydb`.`Vasca` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Badge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Badge` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Badge` (
  `BadgeID` INT UNSIGNED NOT NULL,
  `stato` ENUM('A', 'D') NOT NULL,
  PRIMARY KEY (`BadgeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Accesso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Accesso` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Accesso` (
  `istante` TIMESTAMP NOT NULL,
  `Badge` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`istante`, `Badge`),
  INDEX `BadgeID_idx` (`Badge` ASC) VISIBLE,
  INDEX `Accesso_idx` (`istante` ASC) VISIBLE,
  CONSTRAINT `fk_Accesso_Badge`
    FOREIGN KEY (`Badge`)
    REFERENCES `mydb`.`Badge` (`BadgeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Utilizzatore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Utilizzatore` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Utilizzatore` (
  `CF` CHAR(16) NOT NULL,
  `indirizzo` VARCHAR(60) NOT NULL,
  `nome` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`CF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Utente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Utente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Utente` (
  `Utilizzatore` CHAR(16) NOT NULL,
  `Badge` INT UNSIGNED NOT NULL,
  `inizioBadge` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Utilizzatore`),
  INDEX `Badge_idx` (`Badge` ASC) VISIBLE,
  UNIQUE INDEX `Badge_UNIQUE` (`Badge` ASC) VISIBLE,
  CONSTRAINT `utente_utilizzatore`
    FOREIGN KEY (`Utilizzatore`)
    REFERENCES `mydb`.`Utilizzatore` (`CF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `utente_badge`
    FOREIGN KEY (`Badge`)
    REFERENCES `mydb`.`Badge` (`BadgeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Addetto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Addetto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Addetto` (
  `Utilizzatore` CHAR(16) NOT NULL,
  `username` VARCHAR(30) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Utilizzatore`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_addetto_utilizzatore`
    FOREIGN KEY (`Utilizzatore`)
    REFERENCES `mydb`.`Utilizzatore` (`CF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Iscrizione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Iscrizione` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Iscrizione` (
  `Corso` INT UNSIGNED NOT NULL,
  `Utente` CHAR(16) NOT NULL,
  PRIMARY KEY (`Corso`, `Utente`),
  INDEX `usato_idx` (`Utente` ASC) VISIBLE,
  CONSTRAINT `fk_iscrizione_corso`
    FOREIGN KEY (`Corso`)
    REFERENCES `mydb`.`Corso` (`CorsoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_iscrizione_utente`
    FOREIGN KEY (`Utente`)
    REFERENCES `mydb`.`Utente` (`Utilizzatore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Badge_Storico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Badge_Storico` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Badge_Storico` (
  `Utente` CHAR(16) NOT NULL,
  `Badge` INT UNSIGNED NOT NULL,
  `inizio` TIMESTAMP NOT NULL,
  `fine` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Utente`, `Badge`),
  INDEX `Badge_idx` (`Badge` ASC) VISIBLE,
  CONSTRAINT `fk_Badge_Storico_Utente`
    FOREIGN KEY (`Utente`)
    REFERENCES `mydb`.`Utente` (`Utilizzatore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Badge_Storico_Badge`
    FOREIGN KEY (`Badge`)
    REFERENCES `mydb`.`Badge` (`BadgeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cellulare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cellulare` ;

CREATE TABLE IF NOT EXISTS `mydb`.`cellulare` (
  `cellulare` CHAR(10) NOT NULL,
  `Utilizzatore` CHAR(16) NOT NULL,
  PRIMARY KEY (`cellulare`, `Utilizzatore`),
  INDEX `Utilizzatore_idx` (`Utilizzatore` ASC) VISIBLE,
  CONSTRAINT `fk_utilizzatore_cellulare`
    FOREIGN KEY (`Utilizzatore`)
    REFERENCES `mydb`.`Utilizzatore` (`CF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefono`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`telefono` ;

CREATE TABLE IF NOT EXISTS `mydb`.`telefono` (
  `telefono` CHAR(10) NOT NULL,
  `Utilizzatore` CHAR(16) NOT NULL,
  PRIMARY KEY (`telefono`, `Utilizzatore`),
  INDEX `Utilizzatore_idx` (`Utilizzatore` ASC) VISIBLE,
  CONSTRAINT `fk_utilizzatore_telefono`
    FOREIGN KEY (`Utilizzatore`)
    REFERENCES `mydb`.`Utilizzatore` (`CF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`email` ;

CREATE TABLE IF NOT EXISTS `mydb`.`email` (
  `email` VARCHAR(40) NOT NULL,
  `Utilizzatore` CHAR(16) NOT NULL,
  PRIMARY KEY (`email`, `Utilizzatore`),
  INDEX `Utilizzatore_idx` (`Utilizzatore` ASC) VISIBLE,
  CONSTRAINT `fk_utilizzatore_email`
    FOREIGN KEY (`Utilizzatore`)
    REFERENCES `mydb`.`Utilizzatore` (`CF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- procedure login
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`login`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `login` (
    IN  vUsername VARCHAR(30),
    IN  vPassword VARCHAR(30),
    OUT vRole     INT
)
BEGIN
    DECLARE cnt INT DEFAULT 0;

    -- Conto quanti matching esistono
    SELECT COUNT(*) INTO cnt
    FROM Addetto
    WHERE username = vUsername
      AND password = MD5(vPassword);

    -- Imposto vRole: 1 = OK, 3 = credenziali errate
    IF cnt = 1 THEN
        SET vRole = 1;
    ELSE
        SET vRole = 3;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure registrazioneNuovoUtente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`registrazioneNuovoUtente`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE registrazioneNuovoUtente(
  IN p_CF        CHAR(16),
  IN p_indirizzo VARCHAR(60),
  IN p_nome      VARCHAR(30),
  IN p_Badge     INT UNSIGNED,
  IN p_email     VARCHAR(40),
  IN p_telefono  CHAR(10),
  IN p_cellulare CHAR(10),
  IN p_iscrizione INT
)
BEGIN
  DECLARE statoBadge ENUM('A', 'D');

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    START TRANSACTION;

  -- controllo stato del badge
  SELECT stato INTO statoBadge FROM Badge WHERE BadgeID = p_Badge;

  IF statoBadge <> 'D' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Badge non disponibile: già utilizzato';
  END IF;

  -- aggiornamento stato del badge
  UPDATE Badge SET stato = 'A' WHERE BadgeID = p_Badge;

  -- inserimento Utilizzatore
  IF NOT EXISTS (
        SELECT 1
        FROM Utilizzatore
        WHERE CF = p_CF
    ) THEN
        INSERT INTO Utilizzatore (CF, indirizzo, nome)
        VALUES (p_CF, p_indirizzo, p_nome);
    END IF;

  -- inserimento Utente
  INSERT INTO Utente(Utilizzatore, Badge, inizioBadge)
  VALUES (p_CF, p_Badge, NOW());

  -- inserimento contatti
  IF p_email IS NOT NULL THEN
    INSERT INTO email(email, Utilizzatore) VALUES(p_email, p_CF);
  END IF;

  IF p_telefono IS NOT NULL THEN
    INSERT INTO telefono(telefono, Utilizzatore) VALUES(p_telefono, p_CF);
  END IF;

  IF p_cellulare IS NOT NULL THEN
    INSERT INTO cellulare(cellulare, Utilizzatore) VALUES(p_cellulare, p_CF);
  END IF;

  -- iscrizione al corso
  INSERT INTO Iscrizione(Utente, Corso)
  VALUES (p_CF, p_iscrizione);

  COMMIT;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure aggiornaContattiUtilizzatore
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiornaContattiUtilizzatore`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE aggiornaContattiUtilizzatore(
  IN p_CF          CHAR(16),
  IN p_email       VARCHAR(40),
  IN p_telefono    CHAR(10),
  IN p_cellulare   CHAR(10),
  IN p_operazione  INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;

  -- Controllo che l'utilizzatore esista
  IF NOT EXISTS (SELECT 1 FROM Utilizzatore WHERE CF = p_CF) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Utilizzatore non trovato: impossibile aggiornare i contatti';
  END IF;

  -- Email
  IF p_email IS NOT NULL AND p_email <> '' THEN
    IF p_operazione = 1 THEN
      -- Aggiungi un nuovo valore
      INSERT INTO email(email, Utilizzatore)
        VALUES(p_email, p_CF);
    ELSEIF p_operazione = 2 THEN
      -- Rimuovi solo il valore specifico (non tutti)
      DELETE FROM email
      WHERE Utilizzatore = p_CF AND email = p_email;
    END IF;
  END IF;

  -- Telefono
  IF p_telefono IS NOT NULL AND p_telefono <> '' THEN
    IF p_operazione = 1 THEN
      INSERT INTO telefono(telefono, Utilizzatore)
        VALUES(p_telefono, p_CF);
    ELSEIF p_operazione = 2 THEN
      DELETE FROM telefono
      WHERE Utilizzatore = p_CF AND telefono = p_telefono;
    END IF;
  END IF;

  -- Cellulare
  IF p_cellulare IS NOT NULL AND p_cellulare <> '' THEN
    IF p_operazione = 1 THEN
      INSERT INTO cellulare(cellulare, Utilizzatore)
        VALUES(p_cellulare, p_CF);
    ELSEIF p_operazione = 2 THEN
      DELETE FROM cellulare
      WHERE Utilizzatore = p_CF AND cellulare = p_cellulare;
    END IF;
  END IF;

  COMMIT;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure aggiornamentoBadgeUtente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiornamentoBadgeUtente`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE aggiornamentoBadgeUtente(
  IN p_CF    CHAR(16),
  IN p_Badge INT UNSIGNED
)
BEGIN
  DECLARE v_oldBadge   INT;
  DECLARE v_oldInizio  TIMESTAMP;
  DECLARE v_statoNewBadge ENUM('A', 'D');

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;

  -- Verifica lo stato del nuovo badge
  SELECT stato INTO v_statoNewBadge
  FROM Badge
  WHERE BadgeID = p_Badge
  FOR UPDATE;

  IF v_statoNewBadge != 'D' THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Il nuovo badge appartiene a qualcun altro.';
  END IF;

  -- Mi salvo il badge già esistente per salvarlo nella relazione storica
  SELECT Badge, inizioBadge
    INTO v_oldBadge, v_oldInizio
    FROM Utente
   WHERE Utilizzatore = p_CF
   FOR UPDATE;

  -- Salva il vecchio badge nello storico
  INSERT INTO Badge_Storico(Utente, Badge, inizio, fine)
    VALUES(p_CF, v_oldBadge, v_oldInizio, NOW());

  -- Aggiorna l'utente con il nuovo badge
  UPDATE Utente
     SET Badge      = p_Badge,
         inizioBadge = NOW()
   WHERE Utilizzatore = p_CF;

  -- Aggiorna lo stato dei badge
  UPDATE Badge
     SET stato = 'A'
   WHERE BadgeID = p_Badge;

  UPDATE Badge
     SET stato = 'D'
   WHERE BadgeID = v_oldBadge;

  COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure iscriviUtenteACorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`iscriviUtenteACorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE iscriviUtenteACorso(
  IN p_CF     CHAR(16),
  IN p_Corso  INT UNSIGNED
)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
      ROLLBACK;
      RESIGNAL;
  END;

  SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
  START TRANSACTION;

  IF EXISTS (
    SELECT 1
      FROM Corso
     WHERE CorsoID = p_Corso
       AND stato <> 'A'
       AND data_fine > NOW()
       AND num_iscritti < capienza
     FOR UPDATE
  ) THEN
    INSERT INTO Iscrizione(Corso, Utente)
    VALUES (p_Corso, p_CF);
  ELSE
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Il corso non è disponibile per nuove iscrizioni';
  END IF;

  COMMIT;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure controlloIscrizioneACorsoInGiornata
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`controlloIscrizioneACorsoInGiornata`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE controlloIscrizioneACorsoInGiornata (
  IN  p_Badge         INT UNSIGNED,
  OUT p_hasAppuntamenti  BOOLEAN
)
BEGIN
  DECLARE v_CF       CHAR(16);
  DECLARE v_count    INT DEFAULT 0;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET TRANSACTION READ ONLY;
    START TRANSACTION;

  SELECT COUNT(*) INTO v_count
  FROM Appuntamento A
  JOIN Iscrizione I ON A.Corso = I.Corso
  JOIN Utente U ON U.Utilizzatore = I.Utente
  WHERE U.Badge = p_Badge
    AND DATE(A.inizio) = CURRENT_DATE();

	SET p_hasAppuntamenti = (v_count > 0);

	COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure registrazioneAccessoPiscina
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`registrazioneAccessoPiscina`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE registrazioneAccessoPiscina (
    IN p_BadgeID INT UNSIGNED
)
BEGIN
    INSERT INTO Accesso (istante, Badge)
    VALUES (NOW(), p_BadgeID);
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure aggiuntaCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiuntaCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE aggiuntaCorso (
    IN p_minimo INT UNSIGNED,
    IN p_stato ENUM('C', 'P', 'A'),
    IN p_nome VARCHAR(45),
    IN p_costo INT UNSIGNED,
    IN p_data_inizio TIMESTAMP,
    IN p_data_fine TIMESTAMP,
    IN p_capienza INT UNSIGNED
)
BEGIN
    INSERT INTO Corso (
        minimo, stato, nome, costo,
        data_inizio, data_fine, capienza
    )
    VALUES (
        p_minimo, p_stato, p_nome, p_costo,
        p_data_inizio, p_data_fine, p_capienza
    );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificaCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`modificaCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE modificaCorso (
    IN p_CorsoID    INT UNSIGNED,
    IN p_minimo     INT UNSIGNED     ,
    IN p_stato      ENUM('C','P','A') ,
    IN p_nome       VARCHAR(45)      ,
    IN p_costo      INT UNSIGNED     ,
    IN p_data_inizio TIMESTAMP       ,
    IN p_data_fine  TIMESTAMP        ,
    IN p_capienza   INT UNSIGNED
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
	-- se la capienza viene ridotta ma durante l'esecuzione della transazione vengono aggiunti iscritti superando la nuova capienza  dopo l'aggiornamento avremo la capienza inferiore al numero di iscritti, inaccettabile
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    START TRANSACTION;

    UPDATE Corso
    SET
        minimo      = IF(p_minimo     IS NULL, minimo,      p_minimo),
        stato       = IF(p_stato      IS NULL, stato,       p_stato),
        nome        = IF(p_nome       IS NULL, nome,        p_nome),
        costo       = IF(p_costo      IS NULL, costo,       p_costo),
        data_inizio = IF(p_data_inizio IS NULL, data_inizio, p_data_inizio),
        data_fine   = IF(p_data_fine  IS NULL, data_fine,   p_data_fine),
        capienza    = IF(p_capienza   IS NULL, capienza,    p_capienza)
    WHERE CorsoID = p_CorsoID;

    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure annullaCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`annullaCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE annullaCorso (
    IN p_CorsoID INT UNSIGNED
)
BEGIN
    UPDATE Corso
    SET stato = 'A'
    WHERE CorsoID = p_CorsoID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure aggiungiAppuntamento
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiungiAppuntamento`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE aggiungiAppuntamento (
    IN p_CorsoID  INT UNSIGNED,
    IN p_Vasca    VARCHAR(10),
    IN p_inizio   TIMESTAMP,
    IN p_fine     TIMESTAMP
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    START TRANSACTION;

	INSERT INTO Appuntamento (Corso, Vasca, inizio, fine)
	VALUES (p_CorsoID, p_Vasca, p_inizio, p_fine);
	COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificaAppuntamento
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`modificaAppuntamento`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE modificaAppuntamento (
    IN p_CorsoID_old  INT UNSIGNED,
    IN p_inizio_old   TIMESTAMP,
    IN p_CorsoID_new  INT UNSIGNED,
    IN p_Vasca_new    VARCHAR(10),
    IN p_inizio_new   TIMESTAMP,
    IN p_fine_new     TIMESTAMP
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    START TRANSACTION;
        UPDATE Appuntamento
        SET
            Corso  = p_CorsoID_new ,
            Vasca  = IF(p_Vasca_new IS NULL, Vasca, p_Vasca_new),
            inizio = p_inizio_new,
            fine   = IF(p_fine_new IS NULL, fine, p_fine_new)
        WHERE Corso = p_CorsoID_old
		AND inizio = p_inizio_old;
    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminaAppuntamento
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`eliminaAppuntamento`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE eliminaAppuntamento (
    IN p_CorsoID  INT UNSIGNED,
    IN p_inizio   TIMESTAMP
)
BEGIN
    DELETE FROM Appuntamento
     WHERE Corso  = p_CorsoID
       AND inizio = p_inizio;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure aggiuntaAddettoSegreteria
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`aggiuntaAddettoSegreteria`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE aggiuntaAddettoSegreteria (
    IN p_CF         CHAR(16),
    IN p_indirizzo  VARCHAR(60),
    IN p_nome       VARCHAR(30),
    IN p_username   VARCHAR(30),
    IN p_password   VARCHAR(32)
)
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
	START TRANSACTION;

    -- Se non esiste il corrispondente Utilizzatore, lo creo
    IF NOT EXISTS (
        SELECT 1
        FROM Utilizzatore
        WHERE CF = p_CF
    ) THEN
        INSERT INTO Utilizzatore (CF, indirizzo, nome)
        VALUES (p_CF, p_indirizzo, p_nome);
    END IF;

    -- Inserisco l’Addetto
    INSERT INTO Addetto (Utilizzatore, username, password)
    VALUES (p_CF, p_username, md5(p_password));

	COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificaAddettoSegreteria
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`modificaAddettoSegreteria`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE modificaAddettoSegreteria(
    IN p_CF           CHAR(16),
    IN p_nuovoUsername VARCHAR(30),
    IN p_nuovaPassword VARCHAR(32)
)
BEGIN
    UPDATE Addetto
    SET
    password = IF(p_nuovaPassword IS NULL, password, md5(p_nuovaPassword)),
    username = IF(p_nuovoUsername IS NULL, username, p_nuovoUsername)
    WHERE Utilizzatore = p_CF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure rimuoviAddettoSegreteria
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`rimuoviAddettoSegreteria`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE rimuoviAddettoSegreteria (
    IN p_CF CHAR(16)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;

    -- Rimuovo l’addetto
    DELETE FROM Addetto
     WHERE Utilizzatore = p_CF;

    -- Se non rimangono ruoli Utente per quel CF, rimuovo anche Utilizzatore
    IF NOT EXISTS (
        SELECT 1
        FROM Utente
        WHERE Utilizzatore = p_CF
    ) THEN
        DELETE FROM Utilizzatore
         WHERE CF = p_CF;
    END IF;

    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure generareReportAccessi
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`generareReportAccessi`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE generareReportAccessi (
    IN  p_inizio     TIMESTAMP,
    IN  p_fine       TIMESTAMP,
    OUT p_previsti   INT,
    OUT p_effettivi  INT
)
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET TRANSACTION READ ONLY;
    START TRANSACTION;

    -- Calcolo degli accessi previsti:
    -- somma di num_iscritti per ogni appuntamento con inizio nell’intervallo
    SELECT COALESCE(SUM(c.num_iscritti), 0)
    INTO p_previsti
    FROM Appuntamento a
    JOIN Corso c
      ON a.Corso = c.CorsoID
    WHERE a.inizio BETWEEN p_inizio AND p_fine;

    -- Calcolo degli accessi effettivi:
    -- conteggio degli Accesso il cui istante è nell’intervallo
    SELECT COUNT(*)
    INTO p_effettivi
    FROM Accesso
    WHERE istante BETWEEN p_inizio AND p_fine;

    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure visualizzaUtentiIscrittiACorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`visualizzaUtentiIscrittiACorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE visualizzaUtentiIscrittiACorso (
    IN p_CorsoID INT UNSIGNED
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;

    SELECT
        u.Utente    AS CF,
        ut.nome     AS Nome
    FROM Iscrizione u
    JOIN Utilizzatore ut
      ON u.Utente = ut.CF
    WHERE u.Corso = p_CorsoID;
    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure visualizzaCorsiUtente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`visualizzaCorsiUtente`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE visualizzaCorsiUtente (
    IN p_CF CHAR(16)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET TRANSACTION READ ONLY;
    START TRANSACTION;

    SELECT
        c.CorsoID       AS CorsoID,
        c.nome          AS NomeCorso
    FROM Iscrizione i
    JOIN Corso c
      ON i.Corso = c.CorsoID
    WHERE i.Utente = p_CF;

    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure visualizzaAppuntamentiCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`visualizzaAppuntamentiCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE visualizzaAppuntamentiCorso (
    IN p_CorsoID INT UNSIGNED
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET TRANSACTION READ ONLY;
    START TRANSACTION;

    SELECT
        a.inizio  AS Inizio,
        a.fine    AS Fine,
        a.Vasca   AS Vasca
    FROM Appuntamento a
    WHERE a.Corso = p_CorsoID
    ORDER BY a.inizio;

    COMMIT;
END$$

DELIMITER ;
SET SQL_MODE = '';
DROP USER IF EXISTS tornello;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'tornello' IDENTIFIED BY 'tornello';

GRANT EXECUTE ON procedure `mydb`.`registrazioneAccessoPiscina` TO 'tornello';
GRANT EXECUTE ON procedure `mydb`.`controlloIscrizioneACorsoInGiornata` TO 'tornello';
SET SQL_MODE = '';
DROP USER IF EXISTS addetto;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'addetto' IDENTIFIED BY 'addetto';

GRANT EXECUTE ON procedure `mydb`.`aggiornaContattiUtilizzatore` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`aggiornamentoBadgeUtente` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`aggiungiAppuntamento` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`aggiuntaAddettoSegreteria` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`aggiuntaCorso` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`annullaCorso` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`eliminaAppuntamento` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`generareReportAccessi` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`iscriviUtenteACorso` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`modificaAddettoSegreteria` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`modificaAppuntamento` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`modificaCorso` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`registrazioneNuovoUtente` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`rimuoviAddettoSegreteria` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`visualizzaAppuntamentiCorso` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`visualizzaCorsiUtente` TO 'addetto';
GRANT EXECUTE ON procedure `mydb`.`visualizzaUtentiIscrittiACorso` TO 'addetto';
SET SQL_MODE = '';
DROP USER IF EXISTS login;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'login' IDENTIFIED BY 'login';

GRANT EXECUTE ON procedure `mydb`.`login` TO 'login';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Corso_BEFORE_INSERT_date` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Corso_BEFORE_INSERT_date` BEFORE INSERT ON `Corso` FOR EACH ROW
BEGIN
    IF NEW.data_inizio >= NEW.data_fine THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Errore: la data di inizio del corso deve essere precedente alla data di fine';
    END IF;
END;

CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Corso_BEFORE_INSERT_capienza` BEFORE INSERT ON `Corso` FOR EACH ROW
BEGIN
    IF NEW.minimo >= NEW.capienza THEN
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Errore: il numero minimo di partecipanti deve essere inferiore alla capienza del corso';
    END IF;

END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Appuntamento_BEFORE_INSERT_1` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Appuntamento_BEFORE_INSERT_1`
BEFORE INSERT ON `Appuntamento` FOR EACH ROW
BEGIN
    DECLARE v_statoCorso ENUM('C', 'P', 'A');

    SELECT stato
      INTO v_statoCorso
      FROM Corso
     WHERE CorsoID = NEW.Corso
     LIMIT 1
     FOR UPDATE;

    IF v_statoCorso = 'A' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Inserimento Appuntamento negato: il corso risulta annullato.';
    END IF;
END;

CREATE DEFINER = CURRENT_USER TRIGGER `Appuntamento_BEFORE_INSERT_2`
BEFORE INSERT ON `Appuntamento` FOR EACH ROW
BEGIN
    DECLARE v_dataInizioCorso DATE;
    DECLARE v_dataFineCorso   DATE;

    SELECT data_inizio, data_fine
      INTO v_dataInizioCorso, v_dataFineCorso
      FROM Corso
     WHERE CorsoID = NEW.Corso
     LIMIT 1;

    IF DATE(NEW.inizio) < v_dataInizioCorso OR DATE(NEW.fine) > v_dataFineCorso THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Inserimento Appuntamento negato: l\'appuntamento deve svolgersi durante il periodo di erogazione del corso.';
    END IF;
END;

CREATE DEFINER = CURRENT_USER TRIGGER `Appuntamento_BEFORE_INSERT_3`
BEFORE INSERT ON `Appuntamento` FOR EACH ROW
BEGIN
    IF NEW.inizio > NEW.fine THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Inserimento Appuntamento negato: orario di inizio maggiore dell\'orario di fine.';
    END IF;
END;$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Appuntamento_BEFORE_UPDATE_1` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Appuntamento_BEFORE_UPDATE_1`
BEFORE UPDATE ON `Appuntamento` FOR EACH ROW
BEGIN
    DECLARE v_statoCorso ENUM('C', 'P', 'A');

    SELECT stato
      INTO v_statoCorso
      FROM Corso
     WHERE CorsoID = NEW.Corso
     LIMIT 1
     FOR UPDATE;

    IF v_statoCorso = 'A' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Aggiornamento Appuntamento negato: il corso risulta annullato.';
    END IF;
END;

CREATE DEFINER = CURRENT_USER TRIGGER `Appuntamento_BEFORE_UPDATE_2`
BEFORE UPDATE ON `Appuntamento` FOR EACH ROW
BEGIN
    DECLARE v_dataInizioCorso DATE;
    DECLARE v_dataFineCorso   DATE;

    SELECT data_inizio, data_fine
      INTO v_dataInizioCorso, v_dataFineCorso
      FROM Corso
     WHERE CorsoID = NEW.Corso
     LIMIT 1;

    IF DATE(NEW.inizio) < v_dataInizioCorso OR DATE(NEW.fine) > v_dataFineCorso THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Aggiornamento Appuntamento negato: l\'appuntamento deve svolgersi durante il periodo di erogazione del corso.';
    END IF;
END;

CREATE DEFINER = CURRENT_USER TRIGGER `Appuntamento_BEFORE_UPDATE_3`
BEFORE UPDATE ON `Appuntamento` FOR EACH ROW
BEGIN
    IF NEW.inizio > NEW.fine THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Aggiornamento Appuntamento negato: orario di inizio maggiore dell\'orario di fine.';
    END IF;
END;$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Iscrizione_AFTER_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Iscrizione_AFTER_INSERT` AFTER INSERT ON `Iscrizione` FOR EACH ROW
BEGIN
	UPDATE Corso
     SET num_iscritti = num_iscritti + 1
   WHERE CorsoID = NEW.Corso;
END$$


DELIMITER ;
-- begin attached script 'script'
-- Disattiva temporaneamente i controlli sui vincoli di chiave esterna
SET FOREIGN_KEY_CHECKS = 0;

-- Seleziona il database corretto
USE `mydb`;

-- Tronca tutte le tabelle in ordine sicuro (dalle dipendenti alle principali)
TRUNCATE TABLE `Accesso`;
TRUNCATE TABLE `Badge_Storico`;
TRUNCATE TABLE `Iscrizione`;
TRUNCATE TABLE `email`;
TRUNCATE TABLE `telefono`;
TRUNCATE TABLE `cellulare`;
TRUNCATE TABLE `Utente`;
TRUNCATE TABLE `Addetto`;
TRUNCATE TABLE `Utilizzatore`;
TRUNCATE TABLE `Appuntamento`;
TRUNCATE TABLE `Corso`;
TRUNCATE TABLE `Badge`;
TRUNCATE TABLE `Vasca`;

-- Riattiva i controlli sui vincoli di chiave esterna
SET FOREIGN_KEY_CHECKS = 1;

-- Tabella Vasca
INSERT INTO Vasca (nome) VALUES
('Vasca1'), ('Vasca2'), ('Vasca3'), ('Vasca4'), ('Vasca5'), ('Vasca6');

INSERT INTO Corso (minimo, stato, nome, costo, data_inizio, data_fine, capienza) VALUES
(5, 'C', 'Corso Nuoto Base', 100, '2024-09-10 09:00:00', '2025-08-10 10:00:00', 15),
(3, 'C', 'Corso Subacqueo', 200, '2024-09-15 11:00:00', '2025-08-01 12:00:00', 10),
(4, 'C', 'Corso Salvamento', 150, '2024-09-20 14:00:00', '2025-08-15 15:00:00', 8),
(2, 'C', 'Corso AcquaFitness', 80, '2024-09-25 16:00:00', '2025-08-30 17:00:00', 12),
(6, 'C', 'Corso Bambini', 90, '2024-10-01 10:00:00', '2025-08-10 11:00:00', 10),
(5, 'C', 'Corso Triathlon', 250, '2024-10-05 08:00:00', '2025-08-20 09:00:00', 15),
(3, 'C', 'Corso Acrobatica', 120, '2024-10-10 13:00:00', '2025-09-01 14:00:00', 8),
(4, 'C', 'Corso Rilassamento', 70, '2024-10-15 15:00:00', '2025-09-05 16:00:00', 10),
(2, 'C', 'Corso Allenamento', 180, '2024-10-20 17:00:00', '2025-09-10 18:00:00', 12),
(5, 'C', 'Corso Competitivo', 300, '2024-10-25 09:30:00', '2025-09-20 10:30:00', 15),
(4, 'C', 'Corso Nuoto Avanzato', 120, '2024-09-05 09:00:00', '2025-08-15 10:00:00', 12),
(3, 'C', 'Corso Immersioni', 220, '2024-09-12 11:00:00', '2025-08-20 12:00:00', 8),
(5, 'C', 'Corso Primo Soccorso Acquatico', 180, '2024-09-18 14:00:00', '2025-08-05 15:00:00', 10),
(2, 'C', 'Corso Yoga in Piscina', 90, '2024-09-22 16:00:00', '2025-08-20 17:00:00', 15),
(4, 'C', 'Corso Allenamento Intensivo', 150, '2024-09-28 09:30:00', '2025-08-31 10:30:00', 10),
(6, 'C', 'Corso Triathlon Estivo', 300, '2024-10-02 08:00:00', '2025-08-10 09:00:00', 15),
(3, 'C', 'Corso Salvataggio Estivo', 200, '2024-10-08 13:00:00', '2025-09-30 14:00:00', 8),
(2, 'C', 'Corso Acqua Zumba', 80, '2024-10-12 17:00:00', '2025-08-15 18:00:00', 15),
(5, 'C', 'Corso Nuoto per Bambini', 100, '2024-10-18 10:00:00', '2025-08-15 11:00:00', 12),
(4, 'C', 'Corso Resistenza Acquatica', 130, '2024-10-22 09:00:00', '2025-09-20 10:00:00', 12);
-- Tabella Appuntamento
INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2024-09-10 09:00:00', '2024-09-10 10:00:00', 'Vasca1'),
(1, '2024-09-12 09:00:00', '2024-09-12 10:00:00', 'Vasca2'),
(2, '2024-09-15 11:00:00', '2024-09-15 12:00:00', 'Vasca3'),
(2, '2024-09-17 11:00:00', '2024-09-17 12:00:00', 'Vasca4'),
(3, '2024-09-20 14:00:00', '2024-09-20 15:00:00', 'Vasca5'),
(3, '2024-09-22 14:00:00', '2024-09-22 15:00:00', 'Vasca6'),
(4, '2024-09-25 16:00:00', '2024-09-25 17:00:00', 'Vasca1'),
(4, '2024-09-27 16:00:00', '2024-09-27 17:00:00', 'Vasca2'),
(5, '2024-10-01 10:00:00', '2024-10-01 11:00:00', 'Vasca3'),
(5, '2024-10-03 10:00:00', '2024-10-03 11:00:00', 'Vasca4'),
(6, '2024-10-05 08:00:00', '2024-10-05 09:00:00', 'Vasca1'),
(6, '2024-10-07 08:00:00', '2024-10-07 09:00:00', 'Vasca2'),
(7, '2024-10-10 13:00:00', '2024-10-10 14:00:00', 'Vasca3'),
(7, '2024-10-12 13:00:00', '2024-10-12 14:00:00', 'Vasca4'),
(8, '2024-10-15 15:00:00', '2024-10-15 16:00:00', 'Vasca5'),
(8, '2024-10-17 15:00:00', '2024-10-17 16:00:00', 'Vasca6'),
(9, '2024-10-20 17:00:00', '2024-10-20 18:00:00', 'Vasca1'),
(9, '2024-10-22 17:00:00', '2024-10-22 18:00:00', 'Vasca2'),
(10, '2024-10-25 09:30:00', '2024-10-25 10:30:00', 'Vasca3'),
(10, '2024-10-27 09:30:00', '2024-10-27 10:30:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-06-02 09:00:00', '2025-06-02 10:00:00', 'Vasca1'),
(2, '2025-06-02 11:00:00', '2025-06-02 12:00:00', 'Vasca2'),
(3, '2025-06-02 14:00:00', '2025-06-02 15:00:00', 'Vasca3'),
(4, '2025-06-02 16:00:00', '2025-06-02 17:00:00', 'Vasca4'),
(5, '2025-06-03 09:00:00', '2025-06-03 10:00:00', 'Vasca5'),
(6, '2025-06-03 11:00:00', '2025-06-03 12:00:00', 'Vasca6'),
(7, '2025-06-03 14:00:00', '2025-06-03 15:00:00', 'Vasca1'),
(8, '2025-06-03 16:00:00', '2025-06-03 17:00:00', 'Vasca2'),
(9, '2025-06-04 09:00:00', '2025-06-04 10:00:00', 'Vasca3'),
(10, '2025-06-04 11:00:00', '2025-06-04 12:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-06-04 14:00:00', '2025-06-04 15:00:00', 'Vasca1'),
(2, '2025-06-04 16:00:00', '2025-06-04 17:00:00', 'Vasca2'),
(3, '2025-06-05 09:00:00', '2025-06-05 10:00:00', 'Vasca3'),
(4, '2025-06-05 11:00:00', '2025-06-05 12:00:00', 'Vasca4'),
(5, '2025-06-05 14:00:00', '2025-06-05 15:00:00', 'Vasca5'),
(6, '2025-06-05 16:00:00', '2025-06-05 17:00:00', 'Vasca6'),
(7, '2025-06-06 09:00:00', '2025-06-06 10:00:00', 'Vasca1'),
(8, '2025-06-06 11:00:00', '2025-06-06 12:00:00', 'Vasca2'),
(9, '2025-06-06 14:00:00', '2025-06-06 15:00:00', 'Vasca3'),
(10, '2025-06-06 16:00:00', '2025-06-06 17:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-06-09 09:00:00', '2025-06-09 10:00:00', 'Vasca1'),
(2, '2025-06-09 11:00:00', '2025-06-09 12:00:00', 'Vasca2'),
(3, '2025-06-09 14:00:00', '2025-06-09 15:00:00', 'Vasca3'),
(4, '2025-06-09 16:00:00', '2025-06-09 17:00:00', 'Vasca4'),
(5, '2025-06-10 09:00:00', '2025-06-10 10:00:00', 'Vasca5'),
(6, '2025-06-10 11:00:00', '2025-06-10 12:00:00', 'Vasca6'),
(7, '2025-06-10 14:00:00', '2025-06-10 15:00:00', 'Vasca1'),
(8, '2025-06-10 16:00:00', '2025-06-10 17:00:00', 'Vasca2'),
(9, '2025-06-11 09:00:00', '2025-06-11 10:00:00', 'Vasca3'),
(10, '2025-06-11 11:00:00', '2025-06-11 12:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(11, '2025-06-11 14:00:00', '2025-06-11 15:00:00', 'Vasca1'),
(12, '2025-06-11 16:00:00', '2025-06-11 17:00:00', 'Vasca2'),
(13, '2025-06-12 09:00:00', '2025-06-12 10:00:00', 'Vasca3'),
(14, '2025-06-12 11:00:00', '2025-06-12 12:00:00', 'Vasca4'),
(15, '2025-06-12 14:00:00', '2025-06-12 15:00:00', 'Vasca5'),
(16, '2025-06-12 16:00:00', '2025-06-12 17:00:00', 'Vasca6'),
(17, '2025-06-13 09:00:00', '2025-06-13 10:00:00', 'Vasca1'),
(18, '2025-06-13 11:00:00', '2025-06-13 12:00:00', 'Vasca2'),
(19, '2025-06-13 14:00:00', '2025-06-13 15:00:00', 'Vasca3'),
(20, '2025-06-13 16:00:00', '2025-06-13 17:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-06-16 09:00:00', '2025-06-16 10:00:00', 'Vasca1'),
(2, '2025-06-16 11:00:00', '2025-06-16 12:00:00', 'Vasca2'),
(3, '2025-06-16 14:00:00', '2025-06-16 15:00:00', 'Vasca3'),
(4, '2025-06-16 16:00:00', '2025-06-16 17:00:00', 'Vasca4'),
(5, '2025-06-17 09:00:00', '2025-06-17 10:00:00', 'Vasca5'),
(6, '2025-06-17 11:00:00', '2025-06-17 12:00:00', 'Vasca6'),
(7, '2025-06-17 14:00:00', '2025-06-17 15:00:00', 'Vasca1'),
(8, '2025-06-17 16:00:00', '2025-06-17 17:00:00', 'Vasca2'),
(9, '2025-06-18 09:00:00', '2025-06-18 10:00:00', 'Vasca3'),
(10, '2025-06-18 11:00:00', '2025-06-18 12:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-06-18 14:00:00', '2025-06-18 15:00:00', 'Vasca1'),
(2, '2025-06-18 16:00:00', '2025-06-18 17:00:00', 'Vasca2'),
(3, '2025-06-19 09:00:00', '2025-06-19 10:00:00', 'Vasca3'),
(4, '2025-06-19 11:00:00', '2025-06-19 12:00:00', 'Vasca4'),
(5, '2025-06-19 14:00:00', '2025-06-19 15:00:00', 'Vasca5'),
(6, '2025-06-19 16:00:00', '2025-06-19 17:00:00', 'Vasca6'),
(7, '2025-06-20 09:00:00', '2025-06-20 10:00:00', 'Vasca1'),
(8, '2025-06-20 11:00:00', '2025-06-20 12:00:00', 'Vasca2'),
(9, '2025-06-20 14:00:00', '2025-06-20 15:00:00', 'Vasca3'),
(10, '2025-06-20 16:00:00', '2025-06-20 17:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-06-23 09:00:00', '2025-06-23 10:00:00', 'Vasca1'),
(2, '2025-06-23 11:00:00', '2025-06-23 12:00:00', 'Vasca2'),
(3, '2025-06-23 14:00:00', '2025-06-23 15:00:00', 'Vasca3'),
(4, '2025-06-23 16:00:00', '2025-06-23 17:00:00', 'Vasca4'),
(5, '2025-06-24 09:00:00', '2025-06-24 10:00:00', 'Vasca5'),
(6, '2025-06-24 11:00:00', '2025-06-24 12:00:00', 'Vasca6'),
(7, '2025-06-24 14:00:00', '2025-06-24 15:00:00', 'Vasca1'),
(8, '2025-06-24 16:00:00', '2025-06-24 17:00:00', 'Vasca2'),
(9, '2025-06-25 09:00:00', '2025-06-25 10:00:00', 'Vasca3'),
(10, '2025-06-25 11:00:00', '2025-06-25 12:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-06-25 14:00:00', '2025-06-25 15:00:00', 'Vasca1'),
(2, '2025-06-25 16:00:00', '2025-06-25 17:00:00', 'Vasca2'),
(3, '2025-06-26 09:00:00', '2025-06-26 10:00:00', 'Vasca3'),
(4, '2025-06-26 11:00:00', '2025-06-26 12:00:00', 'Vasca4'),
(5, '2025-06-26 14:00:00', '2025-06-26 15:00:00', 'Vasca5'),
(6, '2025-06-26 16:00:00', '2025-06-26 17:00:00', 'Vasca6'),
(7, '2025-06-27 09:00:00', '2025-06-27 10:00:00', 'Vasca1'),
(8, '2025-06-27 11:00:00', '2025-06-27 12:00:00', 'Vasca2'),
(9, '2025-06-27 14:00:00', '2025-06-27 15:00:00', 'Vasca3'),
(10, '2025-06-27 16:00:00', '2025-06-27 17:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-06-30 09:00:00', '2025-06-30 10:00:00', 'Vasca1'),
(2, '2025-06-30 11:00:00', '2025-06-30 12:00:00', 'Vasca2'),
(3, '2025-06-30 14:00:00', '2025-06-30 15:00:00', 'Vasca3'),
(4, '2025-06-30 16:00:00', '2025-06-30 17:00:00', 'Vasca4'),
(5, '2025-07-01 09:00:00', '2025-07-01 10:00:00', 'Vasca5'),
(6, '2025-07-01 11:00:00', '2025-07-01 12:00:00', 'Vasca6'),
(7, '2025-07-01 14:00:00', '2025-07-01 15:00:00', 'Vasca1'),
(8, '2025-07-01 16:00:00', '2025-07-01 17:00:00', 'Vasca2'),
(9, '2025-07-02 09:00:00', '2025-07-02 10:00:00', 'Vasca3'),
(10, '2025-07-02 11:00:00', '2025-07-02 12:00:00', 'Vasca4'),
(1, '2025-07-02 14:00:00', '2025-07-02 15:00:00', 'Vasca1'),
(2, '2025-07-02 16:00:00', '2025-07-02 17:00:00', 'Vasca2'),
(3, '2025-07-03 09:00:00', '2025-07-03 10:00:00', 'Vasca3'),
(4, '2025-07-03 11:00:00', '2025-07-03 12:00:00', 'Vasca4'),
(5, '2025-07-03 14:00:00', '2025-07-03 15:00:00', 'Vasca5'),
(6, '2025-07-03 16:00:00', '2025-07-03 17:00:00', 'Vasca6'),
(7, '2025-07-04 09:00:00', '2025-07-04 10:00:00', 'Vasca1'),
(8, '2025-07-04 11:00:00', '2025-07-04 12:00:00', 'Vasca2'),
(9, '2025-07-04 14:00:00', '2025-07-04 15:00:00', 'Vasca3'),
(10, '2025-07-04 16:00:00', '2025-07-04 17:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-07-07 09:00:00', '2025-07-07 10:00:00', 'Vasca1'),
(2, '2025-07-07 11:00:00', '2025-07-07 12:00:00', 'Vasca2'),
(3, '2025-07-07 14:00:00', '2025-07-07 15:00:00', 'Vasca3'),
(4, '2025-07-07 16:00:00', '2025-07-07 17:00:00', 'Vasca4'),
(5, '2025-07-08 09:00:00', '2025-07-08 10:00:00', 'Vasca5'),
(6, '2025-07-08 11:00:00', '2025-07-08 12:00:00', 'Vasca6'),
(7, '2025-07-08 14:00:00', '2025-07-08 15:00:00', 'Vasca1'),
(8, '2025-07-08 16:00:00', '2025-07-08 17:00:00', 'Vasca2'),
(9, '2025-07-09 09:00:00', '2025-07-09 10:00:00', 'Vasca3'),
(10, '2025-07-09 11:00:00', '2025-07-09 12:00:00', 'Vasca4'),
(1, '2025-07-09 14:00:00', '2025-07-09 15:00:00', 'Vasca1'),
(2, '2025-07-09 16:00:00', '2025-07-09 17:00:00', 'Vasca2'),
(3, '2025-07-10 09:00:00', '2025-07-10 10:00:00', 'Vasca3'),
(4, '2025-07-10 11:00:00', '2025-07-10 12:00:00', 'Vasca4'),
(5, '2025-07-10 14:00:00', '2025-07-10 15:00:00', 'Vasca5'),
(6, '2025-07-10 16:00:00', '2025-07-10 17:00:00', 'Vasca6'),
(7, '2025-07-11 09:00:00', '2025-07-11 10:00:00', 'Vasca1'),
(8, '2025-07-11 11:00:00', '2025-07-11 12:00:00', 'Vasca2'),
(9, '2025-07-11 14:00:00', '2025-07-11 15:00:00', 'Vasca3'),
(10, '2025-07-11 16:00:00', '2025-07-11 17:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-07-14 09:00:00', '2025-07-14 10:00:00', 'Vasca1'),
(2, '2025-07-14 11:00:00', '2025-07-14 12:00:00', 'Vasca2'),
(3, '2025-07-14 14:00:00', '2025-07-14 15:00:00', 'Vasca3'),
(4, '2025-07-14 16:00:00', '2025-07-14 17:00:00', 'Vasca4'),
(5, '2025-07-15 09:00:00', '2025-07-15 10:00:00', 'Vasca5'),
(6, '2025-07-15 11:00:00', '2025-07-15 12:00:00', 'Vasca6'),
(7, '2025-07-15 14:00:00', '2025-07-15 15:00:00', 'Vasca1'),
(8, '2025-07-15 16:00:00', '2025-07-15 17:00:00', 'Vasca2'),
(9, '2025-07-16 09:00:00', '2025-07-16 10:00:00', 'Vasca3'),
(10, '2025-07-16 11:00:00', '2025-07-16 12:00:00', 'Vasca4'),
(1, '2025-07-16 14:00:00', '2025-07-16 15:00:00', 'Vasca1'),
(2, '2025-07-16 16:00:00', '2025-07-16 17:00:00', 'Vasca2'),
(3, '2025-07-17 09:00:00', '2025-07-17 10:00:00', 'Vasca3'),
(4, '2025-07-17 11:00:00', '2025-07-17 12:00:00', 'Vasca4'),
(5, '2025-07-17 14:00:00', '2025-07-17 15:00:00', 'Vasca1'),
(6, '2025-07-17 16:00:00', '2025-07-17 17:00:00', 'Vasca2'),
(7, '2025-07-18 09:00:00', '2025-07-18 10:00:00', 'Vasca3'),
(8, '2025-07-18 11:00:00', '2025-07-18 12:00:00', 'Vasca4'),
(9, '2025-07-18 14:00:00', '2025-07-18 15:00:00', 'Vasca5'),
(10, '2025-07-18 16:00:00', '2025-07-18 17:00:00', 'Vasca6'),
(1, '2025-07-21 09:00:00', '2025-07-21 10:00:00', 'Vasca1');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(2, '2025-07-21 11:00:00', '2025-07-21 12:00:00', 'Vasca2'),
(3, '2025-07-21 14:00:00', '2025-07-21 15:00:00', 'Vasca3'),
(4, '2025-07-21 16:00:00', '2025-07-21 17:00:00', 'Vasca4'),
(5, '2025-07-22 09:00:00', '2025-07-22 10:00:00', 'Vasca5'),
(6, '2025-07-22 11:00:00', '2025-07-22 12:00:00', 'Vasca1'),
(7, '2025-07-22 14:00:00', '2025-07-22 15:00:00', 'Vasca2'),
(8, '2025-07-22 16:00:00', '2025-07-22 17:00:00', 'Vasca3'),
(9, '2025-07-23 09:00:00', '2025-07-23 10:00:00', 'Vasca4'),
(10, '2025-07-23 11:00:00', '2025-07-23 12:00:00', 'Vasca1'),
(1, '2025-07-23 14:00:00', '2025-07-23 15:00:00', 'Vasca1'),
(2, '2025-07-23 16:00:00', '2025-07-23 17:00:00', 'Vasca2'),
(3, '2025-07-24 09:00:00', '2025-07-24 10:00:00', 'Vasca3'),
(4, '2025-07-24 11:00:00', '2025-07-24 12:00:00', 'Vasca4'),
(5, '2025-07-24 14:00:00', '2025-07-24 15:00:00', 'Vasca5'),
(6, '2025-07-24 16:00:00', '2025-07-24 17:00:00', 'Vasca6'),
(7, '2025-07-25 09:00:00', '2025-07-25 10:00:00', 'Vasca1'),
(8, '2025-07-25 11:00:00', '2025-07-25 12:00:00', 'Vasca2'),
(9, '2025-07-25 14:00:00', '2025-07-25 15:00:00', 'Vasca3'),
(10, '2025-07-25 16:00:00', '2025-07-25 17:00:00', 'Vasca4');

INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2025-07-28 09:00:00', '2025-07-28 10:00:00', 'Vasca1'),
(2, '2025-07-28 11:00:00', '2025-07-28 12:00:00', 'Vasca2'),
(3, '2025-07-28 14:00:00', '2025-07-28 15:00:00', 'Vasca3'),
(4, '2025-07-28 16:00:00', '2025-07-28 17:00:00', 'Vasca4'),
(5, '2025-07-29 09:00:00', '2025-07-29 10:00:00', 'Vasca5'),
(6, '2025-07-29 11:00:00', '2025-07-29 12:00:00', 'Vasca6'),
(7, '2025-07-29 14:00:00', '2025-07-29 15:00:00', 'Vasca1'),
(8, '2025-07-29 16:00:00', '2025-07-29 17:00:00', 'Vasca2'),
(9, '2025-07-30 09:00:00', '2025-07-30 10:00:00', 'Vasca3'),
(10, '2025-07-30 11:00:00', '2025-07-30 12:00:00', 'Vasca4'),
(1, '2025-07-30 14:00:00', '2025-07-30 15:00:00', 'Vasca1'),
(2, '2025-07-30 16:00:00', '2025-07-30 17:00:00', 'Vasca2'),
(3, '2025-07-31 09:00:00', '2025-07-31 10:00:00', 'Vasca3'),
(4, '2025-07-31 11:00:00', '2025-07-31 12:00:00', 'Vasca4'),
(5, '2025-07-31 14:00:00', '2025-07-31 15:00:00', 'Vasca5'),
(6, '2025-07-31 16:00:00', '2025-07-31 17:00:00', 'Vasca6');

-- Tabella Badge
INSERT INTO Badge (BadgeID, stato) VALUES
(1,'A'), (2,'A'), (3,'A'), (4,'A'), (5,'A'), (6,'A'), (7,'A'), (8,'A'), (9,'A'), (10,'A'), (11,'D'), (12, 'D'),
(13, 'D'), (14, 'D'), (15, 'D');

-- Tabella Utilizzatore
INSERT INTO Utilizzatore (CF, indirizzo, nome) VALUES
('RSSMRA80A01H501Z', 'Via Roma 1', 'Mario Rossi'),
('VRDFRG72B34Y987X', 'Via Milano 2', 'Francesco Verde'),
('BLTMHL65C12L334W', 'Via Napoli 3', 'Luca Bianchi'),
('GNNFRC85D22P612V', 'Via Torino 4', 'Carla Neri'),
('CRTLNZ90E05Q789U', 'Via Genova 5', 'Anna Carta'),
('PPRMTT78F14R456T', 'Via Bologna 6', 'Paola Perri'),
('ZLLMTR83G67S123S', 'Via Firenze 7', 'Silvia Zelli'),
('MRRCLL70H08O987R', 'Via Bari 8', 'Marco Relli'),
('FLLNDR89I45K612Q', 'Via Palermo 9', 'Andrea Felli'),
('TNNPLA95L78M345P', 'Via Catania 10', 'Laura Tanni'),
('BNCPLA92C56A456R', 'Via Verona 12', 'Paola Bianchi'),
('DMRGPP87F34H223S', 'Via Venezia 15', 'Gino Di Marco'),
('FGRNRL81D87K345Z', 'Via Torino 11', 'Renzo Fogari'),
('GLDLRT93L56P789X', 'Via Cagliari 3', 'Laura Galdi'),
('MRCFRN79M09V123W', 'Via Palermo 5', 'Franco Marchetti'),
('NNNRTL88E12Q456U', 'Via Genova 17', 'Tiziana Nanni'),
('PRSLSR95G45B612A', 'Via Napoli 8', 'Sara Parisi'),
('RZZGNN80H67L334Y', 'Via Catania 2', 'Gianna Rezzuti'),
('SNDSMN91I23M789T', 'Via Bologna 9', 'Simone Sandri'),
('VLLCMN86D30O987G', 'Via Milano 6', 'Camilla Valli');

-- Tabella Utente
INSERT INTO Utente (Utilizzatore, Badge, inizioBadge) VALUES
('RSSMRA80A01H501Z', 1, '2024-01-05 10:00:00'),
('VRDFRG72B34Y987X', 2, '2024-01-06 11:00:00'),
('BLTMHL65C12L334W', 3, '2024-01-07 12:00:00'),
('GNNFRC85D22P612V', 4, '2024-01-08 13:00:00'),
('CRTLNZ90E05Q789U', 5, '2024-01-09 14:00:00'),
('PPRMTT78F14R456T', 6, '2024-01-10 15:00:00'),
('ZLLMTR83G67S123S', 7, '2024-01-11 16:00:00'),
('MRRCLL70H08O987R', 8, '2024-01-12 17:00:00'),
('FLLNDR89I45K612Q', 9, '2024-01-13 18:00:00'),
('TNNPLA95L78M345P', 10, '2024-01-14 19:00:00');

-- Tabella Addetto
INSERT INTO Addetto (Utilizzatore, username, password) VALUES
('RSSMRA80A01H501Z', 'mario_rossi', '3afc79b597f88a72528e864cf81856d2'),
('VRDFRG72B34Y987X', 'francesco_verde', '3afc79b597f88a72528e864cf81856d2'),
('BLTMHL65C12L334W', 'luca_bianchi', '3afc79b597f88a72528e864cf81856d2'),
('GNNFRC85D22P612V', 'carla_neri', '3afc79b597f88a72528e864cf81856d2'),
('CRTLNZ90E05Q789U', 'anna_carta', '3afc79b597f88a72528e864cf81856d2'),
('PPRMTT78F14R456T', 'paola_perri', '3afc79b597f88a72528e864cf81856d2'),
('ZLLMTR83G67S123S', 'silvia_zelli', '3afc79b597f88a72528e864cf81856d2'),
('MRRCLL70H08O987R', 'marco_relli', '3afc79b597f88a72528e864cf81856d2'),
('FLLNDR89I45K612Q', 'andrea_felli', '3afc79b597f88a72528e864cf81856d2'),
('TNNPLA95L78M345P', 'laura_tanni', '3afc79b597f88a72528e864cf81856d2');

-- Tabella Iscrizione
INSERT INTO Iscrizione (Corso, Utente) VALUES
(1, 'RSSMRA80A01H501Z'),
(1, 'VRDFRG72B34Y987X'),
(2, 'BLTMHL65C12L334W'),
(2, 'GNNFRC85D22P612V'),
(3, 'CRTLNZ90E05Q789U'),
(3, 'PPRMTT78F14R456T'),
(4, 'ZLLMTR83G67S123S'),
(4, 'MRRCLL70H08O987R'),
(5, 'FLLNDR89I45K612Q'),
(5, 'TNNPLA95L78M345P');

-- Tabella Badge_Storico
INSERT INTO Badge_Storico (Utente, Badge, inizio, fine) VALUES
('RSSMRA80A01H501Z', 1, '2024-01-05 10:00:00', '2024-01-10 09:00:00'),
('VRDFRG72B34Y987X', 2, '2024-01-06 11:00:00', '2024-01-11 10:00:00'),
('BLTMHL65C12L334W', 3, '2024-01-07 12:00:00', '2024-01-12 11:00:00'),
('GNNFRC85D22P612V', 4, '2024-01-08 13:00:00', '2024-01-13 12:00:00'),
('CRTLNZ90E05Q789U', 5, '2024-01-09 14:00:00', '2024-01-14 13:00:00'),
('PPRMTT78F14R456T', 6, '2024-01-10 15:00:00', '2024-01-15 14:00:00'),
('ZLLMTR83G67S123S', 7, '2024-01-11 16:00:00', '2024-01-16 15:00:00'),
('MRRCLL70H08O987R', 8, '2024-01-12 17:00:00', '2024-01-17 16:00:00'),
('FLLNDR89I45K612Q', 9, '2024-01-13 18:00:00', '2024-01-18 17:00:00'),
('TNNPLA95L78M345P', 10, '2024-01-14 19:00:00', '2024-01-19 18:00:00');

-- Tabella cellulare
INSERT INTO cellulare (cellulare, Utilizzatore) VALUES
('3480000001', 'RSSMRA80A01H501Z'),
('3480000002', 'VRDFRG72B34Y987X'),
('3480000003', 'BLTMHL65C12L334W'),
('3480000004', 'GNNFRC85D22P612V'),
('3480000005', 'CRTLNZ90E05Q789U'),
('3480000006', 'PPRMTT78F14R456T'),
('3480000007', 'ZLLMTR83G67S123S'),
('3480000008', 'MRRCLL70H08O987R'),
('3480000009', 'FLLNDR89I45K612Q'),
('3480000010', 'TNNPLA95L78M345P');

-- Tabella telefono
INSERT INTO telefono (telefono, Utilizzatore) VALUES
('0612345678', 'RSSMRA80A01H501Z'),
('0212345678', 'VRDFRG72B34Y987X'),
('0812345678', 'BLTMHL65C12L334W'),
('0112345678', 'GNNFRC85D22P612V'),
('0512345678', 'CRTLNZ90E05Q789U'),
('0612345678', 'PPRMTT78F14R456T'),
('0212345678', 'ZLLMTR83G67S123S'),
('0812345678', 'MRRCLL70H08O987R'),
('0112345678', 'FLLNDR89I45K612Q'),
('0512345678', 'TNNPLA95L78M345P');

-- Tabella email
INSERT INTO email (email, Utilizzatore) VALUES
('mario.rossi@example.com', 'RSSMRA80A01H501Z'),
('francesco.verde@example.com', 'VRDFRG72B34Y987X'),
('luca.bianchi@example.com', 'BLTMHL65C12L334W'),
('carla.neri@example.com', 'GNNFRC85D22P612V'),
('anna.carta@example.com', 'CRTLNZ90E05Q789U'),
('paola.perri@example.com', 'PPRMTT78F14R456T'),
('silvia.zelli@example.com', 'ZLLMTR83G67S123S'),
('marco.relli@example.com', 'MRRCLL70H08O987R'),
('andrea.felli@example.com', 'FLLNDR89I45K612Q'),
('laura.tanni@example.com', 'TNNPLA95L78M345P');

-- Tabella Accesso
INSERT INTO Accesso (istante, Badge) VALUES
('2024-01-10 09:05:00', 1),
('2024-01-12 09:10:00', 1),
('2024-02-01 11:05:00', 2),
('2024-02-03 11:10:00', 2),
('2024-03-01 14:05:00', 3),
('2024-03-03 14:10:00', 3),
('2024-01-15 16:05:00', 4),
('2024-01-17 16:10:00', 4),
('2024-02-10 10:05:00', 5),
('2024-02-12 10:10:00', 5);

-- end attached script 'script'
