package com.neilkhatri.risensiuuu

import android.annotation.SuppressLint
import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton
import android.widget.TextView
import android.widget.TimePicker
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.preference.PreferenceManager
import java.time.LocalDateTime
import java.util.*


class TimeSelectorActivity : AppCompatActivity() {

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_time_selector)
        supportActionBar?.hide()

        // Get alarm time from shared preferences
        val prefs = PreferenceManager.getDefaultSharedPreferences(this)
        val hour = prefs.getInt("hour", 100)
        val minute = prefs.getInt("minute", 100)

        // If alarm time has previously been set, display the timepicker at alarm time
        if (hour != 100) {
            val timeSelector = findViewById<TimePicker>(R.id.timePicker)
            timeSelector.hour = hour
            timeSelector.minute = minute
        }

        val title = findViewById<TextView>(R.id.timeSelectorTitle)
        title.text = when {
            hour != 100 -> "Edit Alarm"
            else -> "Add Alarm"
        }

        configureBackBtn()
        configureSaveBtn()
    }

    @SuppressLint("RestrictedApi")
    @RequiresApi(Build.VERSION_CODES.M)
    private fun configureSaveBtn() {
        val saveBtn = findViewById<Button>(R.id.alarmSaveBtn)
        saveBtn.setOnClickListener {
            val timeSelector = findViewById<TimePicker>(R.id.timePicker)

            // Save time to shared preferences
            val prefs = PreferenceManager.getDefaultSharedPreferences(this)
            val editor = prefs.edit()
            editor.putInt("hour", timeSelector.hour)
            editor.putInt("minute", timeSelector.minute)
            editor.putBoolean("active", true)
            editor.apply()

            // Create alarm through alarm handler
            val alarmHandler = AlarmHandler(this)
            alarmHandler.createAlarm(timeSelector.hour, timeSelector.minute)

            navigateHome()
        }
    }

    private fun configureBackBtn() {
        val backBtn = findViewById<ImageButton>(R.id.timeSelectorBackBtn)
        backBtn.setOnClickListener {
            navigateHome()
        }
    }

    private fun navigateHome() {
        val intent = Intent(this, MainActivity::class.java)
        startActivity(intent)
    }
}
