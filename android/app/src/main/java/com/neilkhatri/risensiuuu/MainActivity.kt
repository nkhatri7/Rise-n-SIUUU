package com.neilkhatri.risensiuuu

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageButton

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        configureHelpBtn()
    }

    private fun configureHelpBtn() {
        val helpBtn = findViewById<ImageButton>(R.id.helpBtn)
        helpBtn.setOnClickListener {
            val intent = Intent(this, HelpActivity::class.java)
            startActivity(intent)
        }
    }
}