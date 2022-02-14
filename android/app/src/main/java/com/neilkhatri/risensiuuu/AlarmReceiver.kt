package com.neilkhatri.risensiuuu

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.net.Uri
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.preference.PreferenceManager

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        println("Receiver is working")

        // Set up an intent that goes to the main activity
        val intentMainActivity = Intent(context, MainActivity::class.java)
        // Set up a pending intent
        val pendingIntent: PendingIntent =
            PendingIntent.getActivity(context, 0, intentMainActivity,
            PendingIntent.FLAG_IMMUTABLE)

        // Get preferred alarm sound
        val prefs = PreferenceManager.getDefaultSharedPreferences(context)
        var alarmSound = R.raw.siuuu_notification_loop
        when (prefs.getString("alarmSound", "looped")) {
            "looped" -> alarmSound = R.raw.siuuu_notification_loop
            "single" -> alarmSound = R.raw.siuuu_audio
        }
        val packageName = context.applicationContext.packageName
        val soundUri : Uri = Uri.parse("android.resource://${packageName}/${alarmSound}")

        val CHANNEL_ID = context.getString(R.string.channel_id)

        // Make the notification parameters
        val builder = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(R.drawable.logo)
            .setContentTitle(context.getString(R.string.app_name))
            .setContentText(context.getString(R.string.notification_subtitle))
            .setStyle(NotificationCompat.BigTextStyle())
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .setSound(soundUri)
            .setAutoCancel(true)

        // Set up the notification service
        val notificationManager : NotificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val notificationChannel = NotificationChannel(CHANNEL_ID,
                context.getString(R.string.channel_name), importance)

            // Create audio attribute
            val audioAttributes = AudioAttributes.Builder()
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .setUsage(AudioAttributes.USAGE_ALARM)
                .build()

            notificationChannel.setSound(soundUri, audioAttributes)
            notificationManager.createNotificationChannel(notificationChannel)
        }

        notificationManager.notify(0, builder.build())

        // Make toggle inactive after notification has been sent
        val editor = prefs.edit()
        editor.putBoolean("active", false)
        editor.apply()
    }
}
