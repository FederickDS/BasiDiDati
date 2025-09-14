# BasiDiDati

Il progetto riguarda la gestione delle iscrizioni e dei corsi in una piscina. L’applicazione fornisce un’interfaccia a riga di comando, avviabile da un IDE (lo sviluppo è stato effettuato con IntelliJ IDEA).

## Tool utilizzati

* *DBMS*: MySQL
* *Build system*: Maven
* *Versione di Java*: 24

## Installazione

1. Clona la repository in locale:

```bash
git clone https://github.com/FederickDS/BasiDiDati.git
```

2. Carica su MySQL lo script presente nel codice sorgente:

```bash
mysql -u root -p < ./BasiDiDati/lastVer.sql
```

> (l’opzione -p è necessaria se l’utente root ha una password, cosa molto probabile).

3. Apri il progetto con Eclipse o IntelliJ IDEA ed eseguilo.
