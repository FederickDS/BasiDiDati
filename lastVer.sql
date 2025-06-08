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
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    START TRANSACTION;
    INSERT INTO Accesso (istante, Badge)
    VALUES (NOW(), p_BadgeID);
    COMMIT;
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

    IF EXISTS (
        SELECT 1
        FROM Corso C
        WHERE C.CorsoID = p_CorsoID
          AND p_inizio < p_fine
          AND C.stato <> 'A'
          AND p_inizio >= C.data_inizio
          AND p_fine <= C.data_fine
    ) THEN
        INSERT INTO Appuntamento (Corso, Vasca, inizio, fine)
        VALUES (p_CorsoID, p_Vasca, p_inizio, p_fine);

        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Errore: dati non validi o conflitto di orario con un altro appuntamento.';
    END IF;
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
DROP TRIGGER IF EXISTS `mydb`.`Corso_BEFORE_UPDATE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Corso_BEFORE_UPDATE` BEFORE UPDATE ON `Corso` FOR EACH ROW
BEGIN
    IF NEW.data_inizio >= NEW.data_fine THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Errore: la data di inizio deve essere precedente alla data di fine';
    END IF;

    IF NEW.minimo >= NEW.capienza THEN
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Errore: il numero minimo di partecipanti deve essere inferiore alla capienza del corso';
    END IF;

    IF NEW.capienza <> OLD.capienza AND NEW.capienza <> NULL AND NEW.capienza < OLD.num_iscritti THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
              'Errore: la nuova capienza non può essere inferiore al numero di iscritti attuali';
    END IF;
END$$


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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
