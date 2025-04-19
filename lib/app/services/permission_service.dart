import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PermissionService {
  static const platform = MethodChannel('com.nexcode.studio.wifi_ftp_app/ftp');

  Future<bool> requestManageExternalStoragePermission() async {
    try {
      final bool result =
          await platform.invokeMethod('requestManageExternalStoragePermission');
      return result;
    } catch (e) {
      print('Error requesting permission: $e');
      return false;
    }
  }

  Future<bool> isManageExternalStoragePermissionGranted() async {
    try {
      final bool result = await platform
          .invokeMethod('isManageExternalStoragePermissionGranted');
      return result;
    } catch (e) {
      print('Error checking permission: $e');
      return false;
    }
  }
}
