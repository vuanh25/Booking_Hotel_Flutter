import 'package:get/get.dart';
import 'package:travel_app_flutter/helpers/catch_storage.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/views/auth/login_screen.dart';
import 'package:travel_app_flutter/views/layout/layout_screen.dart';
import 'package:travel_app_flutter/views/on_boarding_screen.dart';


class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(const Duration(seconds: 2));

    if (CatchStorage.get(k_userKey) == null) {
      await Get.off(() => const OnBoardingScreen());
      return;
    }

    if (CatchStorage.get(k_userKey) == null) {
      await Get.off(() => const LoginScreen());
      return;
    }

    if (CatchStorage.get(k_userKey) != null) {
      await Get.off(() => const LayoutScreen());
     
      return;
    }
  
    
  }
}
