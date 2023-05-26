

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app_flutter/helpers/catch_storage.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/models/user_model.dart';
import 'package:travel_app_flutter/network/auth_service.dart';
import 'package:travel_app_flutter/network/firestore_service.dart';
import 'package:travel_app_flutter/views/layout/layout_screen.dart';

class RegisterController extends GetxController
{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  

  bool isLoading = false;

  Future<void> createAccount() async
  {
    if (!formKey.currentState!.validate()) return;
    try
    {
      isLoading = true;
      update();
      UserCredential credential = await AuthService.instance.register(email: email.text, password: password.text);


      UserModel model = UserModel(
        uId: credential.user!.uid,
        email: credential.user!.email,
        name: name.text,
        dateOfRegister: DateFormat("y/M/d ,H:m:s").format(DateTime.now()),
      );

      await FireStoreServic.instance.saveUser(model);

      var convertDataToJson = jsonEncode(model.toMap);

      await CatchStorage.save(k_userKey, convertDataToJson);

      MainUser.instance.update();

      await Get.off(() => const LayoutScreen());
      
      isLoading = false;
      update();
    }  on FirebaseAuthException catch (error)
    {
      isLoading = false;
      update();
      Get.closeAllSnackbars();
       Get.snackbar(
        "Something is wrong!",
        error.message!,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    }catch (error) {
      isLoading = false;
      update();

      Get.closeAllSnackbars();
      Get.snackbar(
        "Something is wrong!",
        "Please try again another time",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    }
  }
}