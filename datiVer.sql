-- File: insert_samples.sql
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
('Vasca1'), ('Vasca2'), ('Vasca3'), ('Vasca4'), ('Vasca5'),
('Vasca6'), ('Vasca7'), ('Vasca8'), ('Vasca9'), ('Vasca10');

INSERT INTO Corso (minimo, stato, nome, costo, data_inizio, data_fine, capienza) VALUES
(5, 'C', 'Corso Nuoto Base', 100, '2024-09-10 09:00:00', '2025-07-10 10:00:00', 15),
(3, 'P', 'Corso Subacqueo', 200, '2024-09-15 11:00:00', '2025-08-01 12:00:00', 10),
(4, 'C', 'Corso Salvamento', 150, '2024-09-20 14:00:00', '2025-08-15 15:00:00', 8),
(2, 'C', 'Corso AcquaFitness', 80, '2024-09-25 16:00:00', '2025-07-30 17:00:00', 12),
(6, 'P', 'Corso Bambini', 90, '2024-10-01 10:00:00', '2025-08-10 11:00:00', 10),
(5, 'P', 'Corso Triathlon', 250, '2024-10-05 08:00:00', '2025-08-20 09:00:00', 15),
(3, 'P', 'Corso Acrobatica', 120, '2024-10-10 13:00:00', '2025-09-01 14:00:00', 8),
(4, 'C', 'Corso Rilassamento', 70, '2024-10-15 15:00:00', '2025-09-05 16:00:00', 10),
(2, 'P', 'Corso Allenamento', 180, '2024-10-20 17:00:00', '2025-09-10 18:00:00', 12),
(5, 'P', 'Corso Competitivo', 300, '2024-10-25 09:30:00', '2025-09-20 10:30:00', 15),
(4, 'C', 'Corso Nuoto Avanzato', 120, '2024-09-05 09:00:00', '2025-07-15 10:00:00', 12),
(3, 'P', 'Corso Immersioni', 220, '2024-09-12 11:00:00', '2025-08-20 12:00:00', 8),
(5, 'C', 'Corso Primo Soccorso Acquatico', 180, '2024-09-18 14:00:00', '2025-07-05 15:00:00', 10),
(2, 'P', 'Corso Yoga in Piscina', 90, '2024-09-22 16:00:00', '2025-07-20 17:00:00', 15),
(4, 'P', 'Corso Allenamento Intensivo', 150, '2024-09-28 09:30:00', '2025-08-31 10:30:00', 10),
(6, 'C', 'Corso Triathlon Estivo', 300, '2024-10-02 08:00:00', '2025-07-10 09:00:00', 15),
(3, 'C', 'Corso Salvataggio Estivo', 200, '2024-10-08 13:00:00', '2025-09-30 14:00:00', 8),
(2, 'C', 'Corso Acqua Zumba', 80, '2024-10-12 17:00:00', '2025-07-15 18:00:00', 15),
(5, 'P', 'Corso Nuoto per Bambini', 100, '2024-10-18 10:00:00', '2025-08-15 11:00:00', 12),
(4, 'C', 'Corso Resistenza Acquatica', 130, '2024-10-22 09:00:00', '2025-09-20 10:00:00', 12);
-- Tabella Appuntamento
INSERT INTO Appuntamento (Corso, inizio, fine, Vasca) VALUES
(1, '2024-09-10 09:00:00', '2024-09-10 10:00:00', 'Vasca1'),
(1, '2024-09-12 09:00:00', '2024-09-12 10:00:00', 'Vasca2'),
(2, '2024-09-15 11:00:00', '2024-09-15 12:00:00', 'Vasca3'),
(2, '2024-09-17 11:00:00', '2024-09-17 12:00:00', 'Vasca4'),
(3, '2024-09-20 14:00:00', '2024-09-20 15:00:00', 'Vasca5'),
(3, '2024-09-22 14:00:00', '2024-09-22 15:00:00', 'Vasca6'),
(4, '2024-09-25 16:00:00', '2024-09-25 17:00:00', 'Vasca7'),
(4, '2024-09-27 16:00:00', '2024-09-27 17:00:00', 'Vasca8'),
(5, '2024-10-01 10:00:00', '2024-10-01 11:00:00', 'Vasca9'),
(5, '2024-10-03 10:00:00', '2024-10-03 11:00:00', 'Vasca10'),
(6, '2024-10-05 08:00:00', '2024-10-05 09:00:00', 'Vasca1'),
(6, '2024-10-07 08:00:00', '2024-10-07 09:00:00', 'Vasca2'),
(7, '2024-10-10 13:00:00', '2024-10-10 14:00:00', 'Vasca3'),
(7, '2024-10-12 13:00:00', '2024-10-12 14:00:00', 'Vasca4'),
(8, '2024-10-15 15:00:00', '2024-10-15 16:00:00', 'Vasca5'),
(8, '2024-10-17 15:00:00', '2024-10-17 16:00:00', 'Vasca6'),
(9, '2024-10-20 17:00:00', '2024-10-20 18:00:00', 'Vasca7'),
(9, '2024-10-22 17:00:00', '2024-10-22 18:00:00', 'Vasca8'),
(10, '2024-10-25 09:30:00', '2024-10-25 10:30:00', 'Vasca9'),
(10, '2024-10-27 09:30:00', '2024-10-27 10:30:00', 'Vasca10'),
(11, '2024-09-05 09:00:00', '2024-09-05 10:00:00', 'Vasca1'),
(11, '2024-09-07 09:00:00', '2024-09-07 10:00:00', 'Vasca2'),
(12, '2024-09-12 11:00:00', '2024-09-12 12:00:00', 'Vasca3'),
(12, '2024-09-14 11:00:00', '2024-09-14 12:00:00', 'Vasca4'),
(13, '2024-09-18 14:00:00', '2024-09-18 15:00:00', 'Vasca5'),
(13, '2024-09-20 14:00:00', '2024-09-20 15:00:00', 'Vasca6'),
(14, '2024-09-22 16:00:00', '2024-09-22 17:00:00', 'Vasca7'),
(14, '2024-09-24 16:00:00', '2024-09-24 17:00:00', 'Vasca8'),
(15, '2024-09-28 09:30:00', '2024-09-28 10:30:00', 'Vasca9'),
(15, '2024-09-30 09:30:00', '2024-09-30 10:30:00', 'Vasca10'),
(16, '2024-10-02 08:00:00', '2024-10-02 09:00:00', 'Vasca1'),
(16, '2024-10-04 08:00:00', '2024-10-04 09:00:00', 'Vasca2'),
(17, '2024-10-08 13:00:00', '2024-10-08 14:00:00', 'Vasca3'),
(17, '2024-10-10 13:00:00', '2024-10-10 14:00:00', 'Vasca4'),
(18, '2024-10-12 17:00:00', '2024-10-12 18:00:00', 'Vasca5'),
(18, '2024-10-14 17:00:00', '2024-10-14 18:00:00', 'Vasca6'),
(19, '2024-10-18 10:00:00', '2024-10-18 11:00:00', 'Vasca7'),
(19, '2024-10-20 10:00:00', '2024-10-20 11:00:00', 'Vasca8'),
(20, '2024-10-22 09:00:00', '2024-10-22 10:00:00', 'Vasca9'),
(20, '2024-10-24 09:00:00', '2024-10-24 10:00:00', 'Vasca10');
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
('RSSMRA80A01H501Z', 'mario_rossi', 'pass1'),
('VRDFRG72B34Y987X', 'francesco_verde', 'pass2'),
('BLTMHL65C12L334W', 'luca_bianchi', 'pass3'),
('GNNFRC85D22P612V', 'carla_neri', 'pass4'),
('CRTLNZ90E05Q789U', 'anna_carta', 'pass5'),
('PPRMTT78F14R456T', 'paola_perri', 'pass6'),
('ZLLMTR83G67S123S', 'silvia_zelli', 'pass7'),
('MRRCLL70H08O987R', 'marco_relli', 'pass8'),
('FLLNDR89I45K612Q', 'andrea_felli', 'pass9'),
('TNNPLA95L78M345P', 'laura_tanni', 'pass10');

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
