import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/ftp_service.dart';
import 'package:flutter/services.dart';

class HomeController extends GetxController {
  final FtpService _ftpService = FtpService();
  final isServerRunning = false.obs;
  final serverAddress = ''.obs;
  final isWifiConnected= false.obs;

  final portController = TextEditingController(text: '2121');
  final usernameController = TextEditingController(text: 'admin');
  final passwordController = TextEditingController(text: 'password');

  var anonymousAccess = true.obs;
  var useFTPS = false.obs;
  var sslMode = true.obs;
  var readOnly = false.obs;

  static const platform = MethodChannel('com.nexcode.studio.wifi_ftp_app/ftp');

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    checkWifiConnection();
    _checkServerStatus();
  }

  @override
  void onClose() {
    portController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> _checkServerStatus() async {
    isServerRunning.value = await _ftpService.isServerRunning();
    if (isServerRunning.value) {
      serverAddress.value = await _ftpService.getServerAddress() ?? '';
    }
  }

  final isPermissionGranted = false.obs;

  Future<void> checkPermission() async {
    isPermissionGranted.value =
        await platform.invokeMethod('isManageExternalStoragePermissionGranted');
  }

  Future<void> requestPermission() async {
    final result =
        await platform.invokeMethod('requestManageExternalStoragePermission');
    isPermissionGranted.value = result ?? false;
  }

  Future<void> startServer() async {
    if (!isPermissionGranted.value) {
      await requestPermission();
      if (!isPermissionGranted.value) {
        Get.snackbar(
          'Permission Required',
          'Storage permission is required to run the FTP server',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    final result = await _ftpService.startServer();
    if (result) {
      isServerRunning.value = true;
      serverAddress.value = await _ftpService.getServerAddress() ?? '';
      print('Server started at: ${serverAddress.value}');
    }
  }

  Future<void> stopServer() async {
    await _ftpService.stopServer();
    isServerRunning.value = false;
    serverAddress.value = '';
  }

  Future<void> updatePort() async {
    final port = int.tryParse(portController.text);
    if (port != null && port > 0 && port < 65536) {
      await _ftpService.setPort(port);
      await _checkServerStatus();
    }
  }

  Future<void> updateCredentials() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    if (username.isNotEmpty && password.isNotEmpty) {
      await _ftpService.setCredentials(username, password);
    }
  }

  Future<void> checkWifiConnection() async {
    try {
      final bool isConnected = await platform.invokeMethod('isConnectedToWifi');
      if (isConnected) {
        print("Device is connected to Wi-Fi");
        isWifiConnected.value = true;
      } else {
        print("Device is not connected to Wi-Fi");
        isWifiConnected.value = false;
      }
    } on PlatformException catch (e) {
      print("Failed to check Wi-Fi connection: '${e.message}'.");
    }
  }
}
