package com.cfssh.launcher

import android.app.Notification
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification

class CyberdeckNotificationListener : NotificationListenerService() {

    companion object {
        @Volatile
        var instance: CyberdeckNotificationListener? = null
            private set

        fun getCurrentNotifications(): List<Map<String, Any>> {
            val service = instance ?: return emptyList()
            return try {
                val active = service.activeNotifications ?: return emptyList()
                active
                    .filter { sbn ->
                        val extras = sbn.notification.extras
                        val title = extras.getCharSequence(Notification.EXTRA_TITLE)?.toString() ?: ""
                        val text = extras.getCharSequence(Notification.EXTRA_TEXT)?.toString() ?: ""
                        title.isNotBlank() || text.isNotBlank()
                    }
                    .sortedByDescending { it.postTime }
                    .take(12)
                    .map { sbn ->
                        val extras = sbn.notification.extras
                        val title = extras.getCharSequence(Notification.EXTRA_TITLE)?.toString() ?: sbn.packageName
                        val text = extras.getCharSequence(Notification.EXTRA_TEXT)?.toString() ?: ""
                        mapOf(
                            "key" to sbn.key,
                            "packageName" to sbn.packageName,
                            "title" to title,
                            "text" to text,
                            "postTime" to sbn.postTime,
                            "isClearable" to sbn.isClearable
                        )
                    }
            } catch (e: Exception) {
                emptyList()
            }
        }
    }

    override fun onListenerConnected() {
        super.onListenerConnected()
        instance = this
    }

    override fun onListenerDisconnected() {
        super.onListenerDisconnected()
        if (instance == this) {
            instance = null
        }
    }

    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        super.onNotificationPosted(sbn)
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification?) {
        super.onNotificationRemoved(sbn)
    }
}

