package com.nexcode.studio.wifi_ftp_app

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat

class PermissionHandler(private val context: Context) {

    @RequiresApi(Build.VERSION_CODES.R)
    fun requestManageExternalStoragePermission(): Boolean {
        return if (!isManageExternalStoragePermissionGranted()) {
            val intent = Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION, Uri.parse("package:" + context.packageName))
            ContextCompat.startActivity(context, intent, null)
            false
        } else {
            true
        }
    }

    @RequiresApi(Build.VERSION_CODES.R)
    fun isManageExternalStoragePermissionGranted(): Boolean {
        return Environment.isExternalStorageManager()
    }
}