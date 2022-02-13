package com.neilkhatri.risensiuuu

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageButton
import android.widget.RadioButton
import android.widget.RadioGroup
import androidx.preference.PreferenceManager

class OptionsActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_options)
        supportActionBar?.hide()

        configureRadioGroup()
        configureBackBtn()
    }

    private fun configureRadioGroup() {
        val prefs = PreferenceManager.getDefaultSharedPreferences(this)
        val editor = prefs.edit()
        val alarmSound = prefs.getString("alarmSound", "looped")

        val radioGroup = findViewById<RadioGroup>(R.id.optionsRadioGroup)

        if (alarmSound == "single") {
            radioGroup.check(R.id.singleSiuuuRadioBtn)
        }

        radioGroup.setOnCheckedChangeListener { radioGroup, checkedId ->
            val radioBtn = findViewById<RadioButton>(checkedId)
            val index = radioGroup.indexOfChild(radioBtn)
            when (index) {
                1 -> editor.putString("alarmSound", "looped")
                2 -> editor.putString("alarmSound", "single")
            }
            editor.apply()
        }
    }

    private fun configureBackBtn() {
        val backBtn = findViewById<ImageButton>(R.id.optionsBackBtn)
        backBtn.setOnClickListener {
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
        }
    }
}
