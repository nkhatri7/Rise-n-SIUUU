package com.neilkhatri.risensiuuu

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import androidx.core.app.NotificationCompat

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        println("Receiver is working")

        // Set up an intent that goes to the main activity
        val intentMainActivity = Intent(context, MainActivity::class.java)
        // Set up a pending intent
        val pendingIntent: PendingIntent =
            PendingIntent.getActivity(context, 0, intentMainActivity,
            PendingIntent.FLAG_IMMUTABLE)

        // Make the notification parameters
        val CHANNEL_ID = "2151512"
        val builder = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(R.drawable.logo)
            .setContentTitle("Rise n' SIUUU")
            .setContentText("SIUUUUUUUU")
            .setStyle(NotificationCompat.BigTextStyle().bigText("SIUUUUUUUU"))
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .setSound(Uri.parse("android.resource://${context.packageName}/${R.raw.siuuu_audio}"))
            .setAutoCancel(true)

        // Set up the notification service
        val notificationManager : NotificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "2151512"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(channelId,
                "Rise n' SIUUU notification channel", importance)
            notificationManager.createNotificationChannel(channel)
        }

        notificationManager.notify(0, builder.build())

        // Play SIUUU sound
        val sound : MediaPlayer = MediaPlayer.create(context, R.raw.siuuu_notification_loop)
        sound.start()
    }
}