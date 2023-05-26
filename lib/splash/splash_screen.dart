import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/controller/splash_controller.dart';
import 'package:travel_app_flutter/helpers/constants.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/traveler1.png"),
            const CustomText(
              text: "BOOKING HOTEL",
              color: k_primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
