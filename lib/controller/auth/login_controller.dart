

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/helpers/catch_storage.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/network/auth_service.dart';
import 'package:travel_app_flutter/network/firestore_service.dart';
import 'package:travel_app_flutter/views/layout/layout_screen.dart';


class LoginController extends GetxController
{
  final email = TextEditingController();
  final password = TextEditingController();
 


  bool isLoading = false; 
  Future<void> login() async
  {
    isLoading = true;
    update();
    try
    {
      UserCredential userCredential =
      await AuthService.instance.login(email: email.text, password: password.text);


      var userData = await FireStoreServic.instance.getUser(userCredential.user!.uid);

      var convertDataToJson = jsonEncode(userData.data());
      await CatchStorage.save(k_userKey, convertDataToJson);
      MainUser.instance.update();

      await Get.off(()=> const LayoutScreen());
       isLoading = false;
       update();

    }
    on FirebaseAuthException catch (error)
    {
      isLoading = false;
      update();

      Get.closeAllSnackbars();
      Get.snackbar(
        "Tài khoản hoặt mật khẩu sai!".tr,
        error.message!,
        backgroundColor: k_primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    } catch(error)
    {
      isLoading = false;
      update();
      Get.closeAllSnackbars();
      Get.snackbar(
        "Something is wrong!".tr,
        "Please try again another time".tr,
        backgroundColor: k_primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    }
  }
}