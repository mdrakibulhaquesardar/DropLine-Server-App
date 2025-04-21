import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class TutorialView extends GetView<HomeController> {
  const TutorialView({super.key});

  Widget tutorialStep(String title, String description, {bool isCode = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: isCode ? Colors.greenAccent : Colors.white70,
              fontFamily: isCode ? 'Courier' : null,
              fontSize: 15.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, -0.1),
            radius: 1.2,
            colors: [
              controller.isServerRunning.value
                  ? const Color(0xFF113D30)
                  : const Color(0xD7000000),
              const Color(0xFF000000),
            ],
            stops: const [0.0001, 1.0],
            focal: const Alignment(0.9, -0.2),
            focalRadius: 0.008,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: ListView(
          children: [
            const Text(

              "User Guide: How to Use DropLine FTP Server",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),

            const Divider(color: Colors.grey, thickness: 0.5, height: 32),

            tutorialStep(
              "Step 1: Launch the Application",
              "Open the DropLine FTP Server app on your Android device. "
                  "You will see a button labeled 'Start FTP Server'. Tap it to activate your personal FTP server. "
                  "This will generate an FTP address, allowing other devices on the same network to access your phone’s storage.",
            ),

            tutorialStep(
              "Step 2: Connect Devices to the Same Wi-Fi Network",
              "Ensure both your Android device and the computer (or other device) you want to connect from are connected to the **same Wi-Fi network**. "
                  "This is essential, as the FTP server works over the local network only.",
            ),

            tutorialStep(
              "Step 3: Copy the FTP Address",
              "Once the server is running, the app will display your unique FTP URL. It will look something like:",
              isCode: false,
            ),
            tutorialStep(
              "",
              "ftp://192.168.0.105:2121",
              isCode: true,
            ),

            tutorialStep(
              "Step 4: Access via Windows File Explorer",
              "On your Windows computer:\n"
                  "1. Press **Win + E** to open File Explorer.\n"
                  "2. Click on the address bar at the top.\n"
                  "3. Paste the FTP address (from Step 3).\n"
                  "4. Hit **Enter**.\n\n"
                  "You should now see your Android device’s shared directories and files appear just like a normal folder.",
            ),

            tutorialStep(
              "Step 5: Transfer Files",
              "You can now drag and drop files between your PC and your Android phone. Copy photos, videos, documents, or entire folders seamlessly without needing a USB cable. "
                  "Changes happen instantly over the local network.",
            ),

            tutorialStep(
              "Step 6 (Optional): Add User Authentication",
              "For added security, go to the app settings and set a username and password. "
                  "When this is configured, any user trying to connect to your FTP server will be prompted for credentials. "
                  "This is useful when you're on a shared network.",
            ),
          ],
        ),
      ),
    );
  }
}
