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
  `num_iscritti` INT UNSIGNED NOT NULL,
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
-- procedure nuovoUtente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`nuovoUtente`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE nuovoUtente(
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
  DECLARE statoBadge CHAR(1);
  DECLARE badgeTrovato INT DEFAULT 0;

  START TRANSACTION;

  -- Controlla che il badge esista e che sia in stato 'D'
  SELECT stato INTO statoBadge FROM Badge WHERE BadgeID = p_Badge;

  -- Se il badge non è in stato 'D', genera errore
  IF statoBadge IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Badge non esistente';
  ELSEIF statoBadge <> 'D' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Badge non disponibile: già utilizzato';
  END IF;

  -- Aggiorna lo stato del badge a 'A'
  UPDATE Badge SET stato = 'A' WHERE BadgeID = p_Badge;

  -- Inserisci l'Utilizzatore
  INSERT INTO Utilizzatore(CF, indirizzo, nome)
  VALUES (p_CF, p_indirizzo, p_nome);

  -- Inserisci l'Utente
  INSERT INTO Utente(Utilizzatore, Badge, inizioBadge)
  VALUES (p_CF, p_Badge, NOW());

  -- Inserisci i contatti se presenti
  IF p_email IS NOT NULL THEN
    INSERT INTO email(email, Utilizzatore) VALUES(p_email, p_CF);
  END IF;

  IF p_telefono IS NOT NULL THEN
    INSERT INTO telefono(telefono, Utilizzatore) VALUES(p_telefono, p_CF);
  END IF;

  IF p_cellulare IS NOT NULL THEN
    INSERT INTO cellulare(cellulare, Utilizzatore) VALUES(p_cellulare, p_CF);
  END IF;

  -- Inserisci l'iscrizione al corso
  INSERT INTO Iscrizione(Utente, Corso)
  VALUES (p_CF, p_iscrizione);

  COMMIT;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateContattiUtilizzatore
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`updateContattiUtilizzatore`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE updateContattiUtilizzatore(
  IN p_CF          CHAR(16),
  IN p_email       VARCHAR(40),
  IN p_telefono    CHAR(10),
  IN p_cellulare   CHAR(10),
  IN p_operazione  INT
)
BEGIN
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
-- procedure updateBadgeUtente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`updateBadgeUtente`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE updateBadgeUtente(
  IN p_CF    CHAR(16),
  IN p_Badge INT UNSIGNED
)
BEGIN
  DECLARE v_oldBadge   INT;
  DECLARE v_oldInizio  TIMESTAMP;
  DECLARE v_statoNewBadge ENUM('A', 'D');

  START TRANSACTION;

  -- Verifica lo stato del nuovo badge
  SELECT stato INTO v_statoNewBadge
  FROM Badge
  WHERE BadgeID = p_Badge
  FOR UPDATE;

  IF v_statoNewBadge IS NULL THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Badge specificato non esiste.';
  ELSEIF v_statoNewBadge != 'D' THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Il nuovo badge non è in stato disattivato (D).';
  END IF;

  -- Mi salvo il badge già esistente per salvarlo nella relazione storica
  SELECT Badge, inizioBadge
    INTO v_oldBadge, v_oldInizio
    FROM Utente
   WHERE Utilizzatore = p_CF
   FOR UPDATE;

  IF v_oldBadge IS NULL THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Utente non trovato: impossibile aggiornare il badge';
  END IF;

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
  DECLARE v_existsUtente    INT DEFAULT 0;
  DECLARE v_existsCorso     INT DEFAULT 0;
  DECLARE v_statoCorso      ENUM('C','P','A');
  DECLARE v_numIscritti     INT;
  DECLARE v_capienza        INT;
  DECLARE v_dataFine        TIMESTAMP;
  DECLARE v_alreadySigned   INT DEFAULT 0;

  START TRANSACTION;

  -- 1) Controlla che l'utente esista
  SELECT COUNT(*)
    INTO v_existsUtente
    FROM Utente
   WHERE Utilizzatore = p_CF;
  IF v_existsUtente = 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Utente non trovato';
  END IF;

  -- 2) Controlla che il corso esista e ne ricava stato, capienza e iscritti
  SELECT COUNT(*) > 0,
         MAX(stato),
         MAX(num_iscritti),
         MAX(capienza),
         MAX(data_fine)
    INTO v_existsCorso,
         v_statoCorso,
         v_numIscritti,
         v_capienza,
         v_dataFine
    FROM Corso
   WHERE CorsoID = p_Corso
   FOR UPDATE;

  IF v_existsCorso = 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Corso non trovato';
  END IF;

  -- 3) Verifica stato e date
  IF NOT (v_statoCorso IN ('P','A')) THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Corso non aperto per le iscrizioni';
  END IF;
  IF v_dataFine < NOW() THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Corso già terminato';
  END IF;

  -- 4) Controlla capienza
  IF v_numIscritti >= v_capienza THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Corso completo';
  END IF;

  -- 5) Controlla che non sia già iscritto
  SELECT COUNT(*)
    INTO v_alreadySigned
    FROM Iscrizione
   WHERE Utente = p_CF
     AND Corso  = p_Corso;
  IF v_alreadySigned > 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Utente già iscritto a questo corso';
  END IF;

  -- 6) Inserimento e aggiornamento contatori
  INSERT INTO Iscrizione(Corso, Utente)
    VALUES(p_Corso, p_CF);

  UPDATE Corso
     SET num_iscritti = num_iscritti + 1
   WHERE CorsoID = p_Corso;

  COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure checkAppuntamentiPerBadge
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`checkAppuntamentiPerBadge`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE checkAppuntamentiPerBadge(
  IN  p_Badge         INT UNSIGNED,
  OUT p_hasAppuntamenti  BOOLEAN
)
BEGIN
  DECLARE v_CF       CHAR(16);
  DECLARE v_count    INT DEFAULT 0;

  -- 1) Trova l'utente associato al badge
  SELECT Utilizzatore
    INTO v_CF
    FROM Utente
   WHERE Badge = p_Badge
   LIMIT 1;

  IF v_CF IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Badge non valido: nessun utente trovato';
  END IF;

  -- 2) Conta gli appuntamenti di oggi per i corsi a cui è iscritto
  SELECT COUNT(*)
    INTO v_count
    FROM Appuntamento A
    JOIN Iscrizione   I ON A.Corso = I.Corso
    WHERE I.Utente = v_CF
      AND DATE(A.inizio) = CURRENT_DATE();

  -- 3) Imposta il parametro OUT
  SET p_hasAppuntamenti = (v_count > 0);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InsertNuovoAccesso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`InsertNuovoAccesso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE InsertNuovoAccesso (
    IN p_BadgeID INT UNSIGNED
)
BEGIN
    -- ISTRUZIONE ATOMICA, non serve transaction
    INSERT INTO Accesso (istante, Badge)
    VALUES (NOW(), p_BadgeID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InserisciCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`InserisciCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE InserisciCorso (
    IN p_minimo INT UNSIGNED,
    IN p_stato ENUM('C', 'P', 'A'),
    IN p_nome VARCHAR(45),
    IN p_costo INT UNSIGNED,
    IN p_num_iscritti INT UNSIGNED,
    IN p_data_inizio TIMESTAMP,
    IN p_data_fine TIMESTAMP,
    IN p_capienza INT UNSIGNED
)
BEGIN
    INSERT INTO Corso (
        minimo, stato, nome, costo,
        num_iscritti, data_inizio, data_fine, capienza
    )
    VALUES (
        p_minimo, p_stato, p_nome, p_costo,
        p_num_iscritti, p_data_inizio, p_data_fine, p_capienza
    );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModificaCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModificaCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE ModificaCorso (
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AnnullaCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AnnullaCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE AnnullaCorso (
    IN p_CorsoID INT UNSIGNED
)
BEGIN
    UPDATE Corso
    SET stato = 'A'
    WHERE CorsoID = p_CorsoID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InserisciAppuntamento
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`InserisciAppuntamento`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE InserisciAppuntamento (
    IN p_CorsoID  INT UNSIGNED,
    IN p_Vasca    VARCHAR(10),
    IN p_inizio   TIMESTAMP,
    IN p_fine     TIMESTAMP
)
BEGIN
    -- Controllo data_inizio < data_fine
    IF p_inizio >= p_fine THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Errore: inizio deve essere precedente a fine';
    END IF;

    INSERT INTO Appuntamento (Corso, Vasca, inizio, fine)
    VALUES (p_CorsoID, p_Vasca, p_inizio, p_fine);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModificaAppuntamento
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModificaAppuntamento`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE ModificaAppuntamento (
    IN p_CorsoID_old  INT UNSIGNED,
    IN p_inizio_old   TIMESTAMP,
    IN p_CorsoID_new  INT UNSIGNED,
    IN p_Vasca_new    VARCHAR(10),
    IN p_inizio_new   TIMESTAMP,
    IN p_fine_new     TIMESTAMP
)
BEGIN
    -- Controllo data_inizio < data_fine
    IF p_inizio_new >= p_fine_new THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Errore: inizio deve essere precedente a fine';
    END IF;

    UPDATE Appuntamento
    SET
        Corso  = p_CorsoID_new,
        Vasca  = p_Vasca_new,
        inizio = p_inizio_new,
        fine   = p_fine_new
    WHERE Corso = p_CorsoID_old
      AND inizio = p_inizio_old;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure RimuoviAppuntamento
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`RimuoviAppuntamento`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE RimuoviAppuntamento (
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
-- procedure InserisciAddetto
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`InserisciAddetto`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE InserisciAddetto (
    IN p_CF         CHAR(16),
    IN p_indirizzo  VARCHAR(60),
    IN p_nome       VARCHAR(30),
    IN p_username   VARCHAR(30),
    IN p_password   VARCHAR(32)
)
BEGIN
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
    VALUES (p_CF, p_username, p_password);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModificaPasswordAddetto
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModificaPasswordAddetto`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE ModificaPasswordAddetto (
    IN p_CF           CHAR(16),
    IN p_nuovaPassword VARCHAR(32)
)
BEGIN
    UPDATE Addetto
    SET password = p_nuovaPassword
    WHERE Utilizzatore = p_CF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure RimuoviAddetto
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`RimuoviAddetto`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE RimuoviAddetto (
    IN p_CF CHAR(16)
)
BEGIN
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ReportAccessi
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ReportAccessi`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE ReportAccessi (
    IN  p_inizio     TIMESTAMP,
    IN  p_fine       TIMESTAMP,
    OUT p_previsti   INT,
    OUT p_effettivi  INT
)
BEGIN
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure VisualizzaIscrittiCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`VisualizzaIscrittiCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE VisualizzaIscrittiCorso (
    IN p_CorsoID INT UNSIGNED
)
BEGIN
    SELECT
        u.Utilizzatore   AS CF,
        ut.nome          AS Nome
    FROM Iscrizione u
    JOIN Utilizzatore ut
      ON u.Utente = ut.CF
    WHERE u.Corso = p_CorsoID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure VisualizzaCorsiUtente
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`VisualizzaCorsiUtente`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE VisualizzaCorsiUtente (
    IN p_CF CHAR(16)
)
BEGIN
    SELECT
        c.CorsoID,
        c.nome          AS NomeCorso
    FROM Iscrizione i
    JOIN Corso c
      ON i.Corso = c.CorsoID
    WHERE i.Utente = p_CF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure VisualizzaAppuntamentiCorso
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`VisualizzaAppuntamentiCorso`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE VisualizzaAppuntamentiCorso (
    IN p_CorsoID INT UNSIGNED
)
BEGIN
    SELECT
        a.inizio  AS Inizio,
        a.fine    AS Fine,
        a.Vasca   AS Vasca
    FROM Appuntamento a
    WHERE a.Corso = p_CorsoID
    ORDER BY a.inizio;
END$$

DELIMITER ;
USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Corso_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Corso_BEFORE_INSERT` BEFORE INSERT ON `Corso` FOR EACH ROW
BEGIN
   -- Controllo data_inizio < data_fine
    IF NEW.data_inizio >= NEW.data_fine THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Errore: la data di inizio deve essere precedente alla data di fine';
    END IF;
    -- Controllo num_iscritti <= capienza
    IF NEW.num_iscritti > NEW.capienza THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Errore: il numero di iscritti non può superare la capienza';
    END IF;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Corso_BEFORE_UPDATE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Corso_BEFORE_UPDATE` BEFORE UPDATE ON `Corso` FOR EACH ROW
BEGIN
    -- Controllo data_inizio < data_fine
    IF NEW.data_inizio >= NEW.data_fine THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Errore: la data di inizio deve essere precedente alla data di fine';
    END IF;
    -- Controllo num_iscritti <= capienza
    IF NEW.num_iscritti > NEW.capienza THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Errore: il numero di iscritti non può superare la capienza';
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
