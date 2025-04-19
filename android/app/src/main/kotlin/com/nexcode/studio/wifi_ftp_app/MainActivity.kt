package com.nexcode.studio.wifi_ftp_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity: FlutterActivity() {
    private val permissionHandler = PermissionHandler(this)

    fun requestManageExternalStoragePermission(): Boolean {
        return permissionHandler.requestManageExternalStoragePermission()
    }

    fun isManageExternalStoragePermissionGranted(): Boolean {
        return permissionHandler.isManageExternalStoragePermissionGranted()
    }
    private val CHANNEL = "com.nexcode.studio.wifi_ftp_app/ftp"
    private var ftpServer: FtpServer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startServer" -> {
                    if (ftpServer == null) {
                        ftpServer = FtpServer(this@MainActivity)
                    }
                    val success = ftpServer?.start() ?: false
                    Log.d("FTPServer", "Server start success: $success")
                    result.success(success)
                }
                "stopServer" -> {
                    ftpServer?.stop()
                    ftpServer = null
                    result.success(null)
                }
                "isServerRunning" -> {
                    val isRunning = ftpServer?.isRunning() ?: false
                    result.success(isRunning)
                }
                "getServerAddress" -> {
                    val address = ftpServer?.getServerAddress()
                    result.success(address)
                }
                "setCredentials" -> {
                    val username = call.argument<String>("username")
                    val password = call.argument<String>("password")
                    if (username != null && password != null) {
                        ftpServer?.setCredentials(username, password)
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Username and password are required", null)
                    }
                }
                "setPort" -> {
                    val port = call.argument<Int>("port")
                    if (port != null) {
                        ftpServer?.setPort(port)
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Port is required", null)
                    }
                }
                "requestManageExternalStoragePermission" -> {
                    val granted = permissionHandler.requestManageExternalStoragePermission()
                    result.success(granted)
                }
                else -> result.notImplemented()
            }
        }
    }
}
