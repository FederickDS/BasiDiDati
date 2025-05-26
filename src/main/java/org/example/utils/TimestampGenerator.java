package org.example.utils;

import java.sql.Timestamp;
import java.util.Calendar;

public class TimestampGenerator {

    /**
     * Genera un oggetto Timestamp a partire dagli elementi data/ora.
     *
     * @param year  l'anno (es. 2025)
     * @param month il mese (1-12)
     * @param day   il giorno del mese (1-31)
     * @param hour  l'ora (0-23)
     * @param minute i minuti (0-59)
     * @param second i secondi (0-59)
     * @return un oggetto Timestamp costruito con i parametri forniti
     */
    public static Timestamp generaTimestamp(int year, int month, int day, int hour, int minute, int second) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month - 1, day, hour, minute, second); // Mese è 0-based in Calendar
        return new Timestamp(calendar.getTimeInMillis());
    }
}