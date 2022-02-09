package com.neilkhatri.risensiuuu

import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.*
import androidx.annotation.RequiresApi
import androidx.preference.PreferenceManager

class MainActivity : AppCompatActivity() {
    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val prefs = PreferenceManager.getDefaultSharedPreferences(this)
        val editor = prefs.edit()
        val hour = prefs.getInt("hour", 100)
        val minute = prefs.getInt("minute", 100)
        val active = prefs.getBoolean("active", false)

        val alarmBtn = findViewById<Button>(R.id.alarmBtn)
        val alarmTimeContainer = findViewById<LinearLayout>(R.id.alarmTimeContainer)
        val alarmTime = findViewById<TextView>(R.id.alarmTime)
        val activeToggle = findViewById<Switch>(R.id.activeToggle)

        if (hour == 100) {
            alarmTimeContainer.visibility = View.INVISIBLE
        } else {
            alarmTime.text = when {
                hour == 0 -> "12:${formatMinute(minute)}am"
                hour < 12 -> "$hour:${formatMinute(minute)}am"
                hour == 12 -> "$hour:${formatMinute(minute)}pm"
                else -> "${hour - 12}:${formatMinute(minute)}pm"
            }

            activeToggle.isChecked = active
            val colour = if (activeToggle.isChecked) resources.getColor(R.color.text_colour, theme)
                    else resources.getColor(R.color.grey, theme)
            alarmTime.setTextColor(colour)

            alarmBtn.visibility = View.INVISIBLE
            alarmTimeContainer.setOnClickListener {
                navigateToTimeSelector()
            }

            activeToggle.setOnCheckedChangeListener { _, isChecked ->
                editor.putBoolean("active", isChecked)
                editor.apply()
                val colour = if (isChecked) resources.getColor(R.color.text_colour, theme)
                        else resources.getColor(R.color.grey, theme)
                alarmTime.setTextColor(colour)

                val alarmHandler = AlarmHandler(this)

                if (isChecked) {
                    // Create alarm if active toggle is on
                    alarmHandler.createAlarm(hour, minute)
                } else {
                    // Cancel alarm if active toggle is off
                    alarmHandler.cancelAlarm()
                }
            }
        }

        configureAlarmBtn()
        configureHelpBtn()
    }

    private fun configureAlarmBtn() {
        val alarmBtn = findViewById<Button>(R.id.alarmBtn)
        alarmBtn.setOnClickListener {
           navigateToTimeSelector()
        }
    }

    private fun configureHelpBtn() {
        val helpBtn = findViewById<ImageButton>(R.id.helpBtn)
        helpBtn.setOnClickListener {
            val intent = Intent(this, HelpActivity::class.java)
            startActivity(intent)
        }
    }

    private fun navigateToTimeSelector() {
        val intent = Intent(this, TimeSelectorActivity::class.java)
        startActivity(intent)
    }

    private fun formatMinute(minute: Int): String {
        return if (minute < 10) "0$minute" else "$minute"
    }
}