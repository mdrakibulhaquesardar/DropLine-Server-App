
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class SettingView extends GetView<HomeController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.8, -0.1),
            // Pushed slightly to the top-right
            radius: 1.2,
            colors: [
              controller.isServerRunning.value
                  ? const Color(0xFF113D30) // Deep green glow (center)
                  : const Color(0xD7000000),
              Color(0xFF000000), // Fades into black
            ],
            stops: [0.0001, 1.0],
            // Adjusted stops for better gradient
            focal: Alignment(0.9, -0.2),
            focalRadius: 0.008,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildSectionTitle('General'),
            _buildTextField('Port number to start FTP server', controller.portController, enabled: false),
            _buildTextField('Username for FTP server access', controller.usernameController , enabled: true),
            _buildPasswordField('Password for FTP server access', controller.passwordController),
            const SizedBox(height: 20),
            _buildSectionTitle('Accessibility'),
            _buildSwitchTile('Anonymous access', controller.anonymousAccess),
            _buildSwitchTile('Use FTPS', controller.useFTPS),
            _buildSwitchTile('SSL Mode', controller.sslMode),
            _buildSwitchTile('Read Only', controller.readOnly),
             SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            // ElevatedButton(
            //     onPressed: (){
            //       controller.updatePort();
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.white,
            //       padding: const EdgeInsets.symmetric(vertical: 15.0),
            //       textStyle: const TextStyle(fontSize: 18 , color: Colors.black),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: const Text('Save Settings')),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller , { bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        readOnly: enabled,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: false,
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, RxBool value) {
    return Obx(() => SwitchListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: value.value,
      onChanged: (newValue) {
        value.value = newValue;
      },
      activeColor: Colors.greenAccent,
      inactiveTrackColor: Colors.grey,
    ));
  }
}