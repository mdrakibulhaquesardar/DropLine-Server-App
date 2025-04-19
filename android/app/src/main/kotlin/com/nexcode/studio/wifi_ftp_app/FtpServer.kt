package com.nexcode.studio.wifi_ftp_app

import android.content.Context
import android.net.wifi.WifiManager
import android.os.Environment
import org.apache.ftpserver.FtpServerFactory
import org.apache.ftpserver.ftplet.Authority
import org.apache.ftpserver.ftplet.UserManager
import org.apache.ftpserver.listener.ListenerFactory
import org.apache.ftpserver.usermanager.PropertiesUserManagerFactory
import org.apache.ftpserver.usermanager.impl.BaseUser
import org.apache.ftpserver.usermanager.impl.WritePermission
import org.apache.ftpserver.FtpServer as ApacheFtpServer
import java.io.File
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.*

class FtpServer(private val context: Context) {
    private var server: org.apache.ftpserver.FtpServer? = null
    private var port: Int = 2121
    private var username: String = "admin"
    private var password: String = "password"

    fun start(): Boolean {
        try {
            val serverFactory = FtpServerFactory()
            val listenerFactory = ListenerFactory()
            
            // Set port
            listenerFactory.port = port

            // Configure user manager
            val userManagerFactory = PropertiesUserManagerFactory()
            val userManager = userManagerFactory.createUserManager()
            
            // Configure user
            val user = BaseUser()
            user.name = username
            user.password = password
            
            // Set home directory to external storage
            val homeDir = Environment.getExternalStorageDirectory().absolutePath
            user.homeDirectory = homeDir
            
            // Set permissions
            val authorities: List<Authority> = listOf(WritePermission())
            user.authorities = authorities
            
            // Save user
            userManager.save(user)
            
            // Set the user manager
            serverFactory.userManager = userManager
            
            // Add listener
            serverFactory.addListener("default", listenerFactory.createListener())
            
            // Create server
            server = serverFactory.createServer()
            
            // Start server
            server?.start()
            return true
        } catch (e: Exception) {
            e.printStackTrace()
            return false
        }
    }

    fun stop() {
        server?.stop()
        server = null
    }

    fun isRunning(): Boolean {
        return server != null && !server!!.isStopped
    }

    fun getServerAddress(): String? {
        return try {
            val wifiManager = context.getSystemService(Context.WIFI_SERVICE) as WifiManager
            val ipAddress = wifiManager.connectionInfo.ipAddress
            val formattedIp = String.format(
                "%d.%d.%d.%d",
                ipAddress and 0xff,
                ipAddress shr 8 and 0xff,
                ipAddress shr 16 and 0xff,
                ipAddress shr 24 and 0xff
            )
            "ftp://$formattedIp:$port"
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }

    fun setCredentials(newUsername: String, newPassword: String) {
        username = newUsername
        password = newPassword
        // Restart server to apply new credentials if it's running
        if (isRunning()) {
            stop()
            start()
        }
    }

    fun setPort(newPort: Int) {
        port = newPort
        // Restart server to apply new port if it's running
        if (isRunning()) {
            stop()
            start()
        }
    }
}