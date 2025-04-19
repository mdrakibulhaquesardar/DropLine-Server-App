import 'package:flutter/services.dart';

class FtpService {
  static const MethodChannel _channel = MethodChannel('com.nexcode.studio.wifi_ftp_app/ftp');
  
  Future<bool> startServer() async {
    try {
      final bool result = await _channel.invokeMethod('startServer');
      return result;
    } on PlatformException catch (e) {
      print('Error starting server: ${e.message}');
      return false;
    }
  }

  Future<void> stopServer() async {
    try {
      await _channel.invokeMethod('stopServer');
    } on PlatformException catch (e) {
      print('Error stopping server: ${e.message}');
    }
  }

  Future<bool> isServerRunning() async {
    try {
      final bool result = await _channel.invokeMethod('isServerRunning');
      return result;
    } on PlatformException catch (e) {
      print('Error checking server status: ${e.message}');
      return false;
    }
  }

  Future<String?> getServerAddress() async {
    try {
      final String? address = await _channel.invokeMethod('getServerAddress');
      return address;
    } on PlatformException catch (e) {
      print('Error getting server address: ${e.message}');
      return null;
    }
  }

  Future<void> setCredentials(String username, String password) async {
    try {
      await _channel.invokeMethod('setCredentials', {
        'username': username,
        'password': password,
      });
    } on PlatformException catch (e) {
      print('Error setting credentials: ${e.message}');
    }
  }

  Future<void> setPort(int port) async {
    try {
      await _channel.invokeMethod('setPort', {
        'port': port,
      });
    } on PlatformException catch (e) {
      print('Error setting port: ${e.message}');
    }
  }
}