import 'package:flutter/material.dart';
import 'package:gentleman_finest/common/app_images.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashController _controller = Get.isRegistered<SplashController>()
      ? Get.find<SplashController>()
      : Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppImages.imgSplash,
        height: Get.height,
        width: Get.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
