

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_app_flutter/helpers/catch_storage.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/views/auth/login_screen.dart';

class ProfileController extends GetxController 
{
  Future<void> logout() async
  {
    FirebaseAuth.instance.signOut();
    await CatchStorage.remove(k_userKey);
    Get.off(()=> const LoginScreen());
  }
}