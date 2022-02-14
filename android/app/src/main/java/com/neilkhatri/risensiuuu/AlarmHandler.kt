package com.neilkhatri.risensiuuu

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import java.util.*

class AlarmHandler(context: Context) {
    /* Create global class values so that both functions can use the same alarm manager and
    pending intent */
    private val alarmManager : AlarmManager =
            context.getSystemService(Context.ALARM_SERVICE) as AlarmManager

    private val intent = Intent(context, AlarmReceiver::class.java)

    private val pendingIntent = PendingIntent.getBroadcast(context, 0, intent,
        PendingIntent.FLAG_IMMUTABLE)

    fun createAlarm(hour: Int, minute: Int) {
        val alarmTime = Calendar.getInstance()
        alarmTime.set(Calendar.HOUR_OF_DAY, hour)
        alarmTime.set(Calendar.MINUTE, minute)
        alarmTime.set(Calendar.SECOND, 0)
        alarmTime.set(Calendar.MILLISECOND, 0)

        val currentTime = Calendar.getInstance()
        val timeComparison = currentTime.compareTo(alarmTime)
        if (timeComparison == 1) {
            val nextDay = alarmTime.get(Calendar.DAY_OF_YEAR) + 1
            alarmTime.set(Calendar.DAY_OF_YEAR, nextDay)
        }

        alarmManager.setExact(AlarmManager.RTC_WAKEUP, alarmTime.timeInMillis, pendingIntent)
    }

    fun cancelAlarm() {
        alarmManager.cancel(pendingIntent)
    }
}
