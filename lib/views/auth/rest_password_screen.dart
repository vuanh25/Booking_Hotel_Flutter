import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_button.dart';
import '../../components/custom_field.dart';
import '../../components/custom_text.dart';
import '../../controller/auth/rest_password_controller.dart';
import '../../helpers/enum_helper.dart';
import '../../helpers/validator_helper.dart';

class RestPasswordScreen extends GetWidget<RestPasswordController> {
  const RestPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const CustomText(
                    text: "Quên mật khẩu",
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  
                  const SizedBox(height: 30),
                  CustomField(
                    hint: "Nhập email của bạn".tr,
                    controller: controller.email,
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: value,
                        type: FieldType.email,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    width: Get.width,
                    text: "Gửi".tr,
                    onPressed: () async {
                      await controller.sendPasswordResetEmail();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}