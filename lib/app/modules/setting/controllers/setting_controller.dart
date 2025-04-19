import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController

  final count = 0.obs;
   var portController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var anonymousAccess = false.obs;
  var useFTPS = false.obs;
  var sslMode = false.obs;
  var readOnly = false.obs;
  var darkMode = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
