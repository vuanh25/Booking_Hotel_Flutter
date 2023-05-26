import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/auth_service.dart';

class RestPasswordController extends GetxController {
  final email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> sendPasswordResetEmail() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await AuthService.instance.restPassword(email.text);
      Get.snackbar(
        "Gửi thành công",
        "Bạn hãy kiễm tra hộp thư email của mình!",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        "Có lỗi xin vui lòng thử lại!".tr,
        error.message!,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    }
  }
}
