import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifi_ftp_app/app/routes/app_pages.dart';
import '../../../units/DottedLinePainter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Gradient Background (Black to Green)
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.5, -0.5),
                  // Pushed slightly to the top-right
                  radius: 1.2,
                  colors: [
                    controller.isServerRunning.value
                        ? Color(0xFF113D30) // Deep green glow (center)
                        : Color(0xD7000000),
                    Color(0xFF000000), // Fades into black
                  ],
                  stops: [0.0001, 1.0],
                  // Adjusted stops for better gradient
                  focal: Alignment(0.8, -0.5),
                  focalRadius: 0.005,
                ),
              ),
            );
          }),

          // 🧊 Bottom Half Transparent Container
          AnimatedContainer(
            duration: Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            child: Positioned(
              bottom: 0,
              child: Obx(() {
                return Container(
                  width: size.width,
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    color: controller.isServerRunning.value
                        ? Color.fromRGBO(17, 40, 35, 0.8)
                        : Color(0x2C000000).withOpacity(0.05),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16), // Soft edges with a radius of 16
                    ),
                  ),
                );
              }),
            ),
          ),
          Obx(() {
            final isRunning = controller.isServerRunning.value;
            return Positioned(
              top: size.height * 0.1,
              left: size.width * 0.5 - 30,
              right: size.width * 0.5 - 30,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(isRunning ? 8 : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: isRunning
                      ? [BoxShadow(color: Colors.greenAccent, blurRadius: 15)]
                      : [],
                ),
                child: Icon(
                  isRunning ? Icons.wifi : Icons.wifi_off,
                  color: isRunning ? Colors.white : Colors.white,
                  size: 30,
                ),
              ),
            );
          }),


          // 🔘 Main UI Stack
          SafeArea(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 🟢 Dotted Line
                  Positioned(
                    child: CustomPaint(
                      size: Size(size.width, size.height * 0.7),
                      painter: DottedLinePainter(),
                    ),
                  ),


                  // 💫 Circle Ripples
                  Obx(() {
                    return AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      width: controller.isServerRunning.value ? 260 : 240,
                      height: controller.isServerRunning.value ? 260 : 240,
                      decoration: BoxDecoration(
                        color: Colors.black38.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                  Obx(() {
                    return AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      width: controller.isServerRunning.value ? 320 : 300,
                      height: controller.isServerRunning.value ? 320 : 300,
                      decoration: BoxDecoration(
                        color: Colors.black38.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    );
                  }),


                  // 🟢 Main Circle with Power Button
                  GestureDetector(
                    onTap: () {
                      if (controller.isServerRunning.value) {
                        controller.stopServer();
                      } else {
                        controller.startServer();
                      }
                    },
                    child: Obx(() {
                      return AnimatedContainer( // Use AnimatedContainer for animation
                        duration: const Duration(milliseconds: 300), // Animation duration
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: controller.isServerRunning.value
                              ? Color.fromRGBO(26, 84, 62, 1)
                              : Colors.grey.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Obx(() {
                            return Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: controller.isServerRunning.value
                                    ? Color(0xFF2ECC71)
                                    : Colors.grey.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.power_settings_new,
                                color: Colors.white,
                                size: 40,
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // 📝 Bottom Text Section
          Positioned(
            bottom: size.height * 0.15,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Obx(() {
                  return Text(
                    controller.isServerRunning.value
                        ? "Server is Active Now"
                        : "Server is Deactivated",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                SizedBox(height: 10),
                Obx(() {
                  return Text(
                    controller.isServerRunning.value
                        ? "Connected to Port ${controller.portController.text}"
                        : "Tap the button to start the server",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
                SizedBox(height: 5),
                Obx(() {
                  return controller.isServerRunning.value
                      ? Text(
                    "${controller.serverAddress.value}",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                      : Container();
                }),
                SizedBox(height: 5),
                // user name and password
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return Text(
                        controller.isServerRunning.value
                            ? "Username: ${controller.usernameController.text}"
                            : "",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                    SizedBox(width: 10),
                    Obx(() {
                      return Text(
                        controller.isServerRunning.value
                            ? "Password: ${controller.passwordController.text}"
                            : "",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),

          // ⚙️ Settings Icon at Bottom
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                onPressed: () {
                  Get.toNamed(Routes.SETTING);
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white60,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
