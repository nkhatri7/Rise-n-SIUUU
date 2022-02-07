package com.neilkhatri.risensiuuu

import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton
import android.widget.TimePicker
import androidx.annotation.RequiresApi

class TimeSelectorActivity : AppCompatActivity() {
    private var hour = 0
    private var minute = 0

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_time_selector)

        configureBackBtn()
        configureSaveBtn()
    }

    @RequiresApi(Build.VERSION_CODES.M)
    private fun configureSaveBtn() {
        val saveBtn = findViewById<Button>(R.id.alarmSaveBtn)
        saveBtn.setOnClickListener {
            val timeSelector = findViewById<TimePicker>(R.id.timePicker)
            hour = timeSelector.hour
            minute = timeSelector.minute
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