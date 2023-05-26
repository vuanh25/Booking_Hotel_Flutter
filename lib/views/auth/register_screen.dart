import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/components/custom_button.dart';
import 'package:travel_app_flutter/components/custom_field.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/helpers/enum_helper.dart';
import 'package:travel_app_flutter/helpers/validator_helper.dart';
import 'package:travel_app_flutter/views/auth/login_screen.dart';

import '../../controller/auth/register_controller.dart';



class RegisterScreen extends GetWidget<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var isObsecure = true.obs;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const CustomText(
                    text: "register",
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 30),
                  CustomField(
                    hint: "Nhập họ tên của bạn",
                    controller: controller.name,
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: controller.name.text,
                        type: FieldType.name,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomField(
                    hint: "Nhập email của bạn",
                    controller: controller.email,
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: controller.email.text,
                        type: FieldType.email,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Obx(() => 
                     CustomField(
                    hint: "Mật khẩu",
                    obscureText: isObsecure.value,
                    controller: controller.password,
                    suffixIcon: Obx(() => GestureDetector(
                      onTap: (){
                        isObsecure.value = !isObsecure.value;
                      },
                      child:Icon(
                                          isObsecure.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: k_primaryColor,
                                        ),
                    )
                    
                    ),
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: controller.password.text,
                        type: FieldType.password,
                      );
                    },
                  ),
                  ),
                 
                  const SizedBox(height: 25),
                  Obx(() => 
                    CustomField(
                    hint: "Nhập lại mật khẩu",
                    controller: controller.confirmPassword,
                    obscureText: isObsecure.value,
                    suffixIcon: Obx(
                      ()=> GestureDetector(
                        onTap: (){
                          isObsecure.value = !isObsecure.value;
                        },
                          child:Icon(
                                          isObsecure.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: k_primaryColor,
                                        ),
                      ),
                    ),
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: controller.confirmPassword.text,
                        matchText: controller.password.text,
                        type: FieldType.confirmPassword,
                      );
                    },
                  ),
                  ),
                  const SizedBox(height: 50),
                  GetBuilder<RegisterController>(builder: (controller) {
                    return CustomButton(
                      width: Get.width,
                      text: "Đăng ký",
                      onPressed: controller.isLoading
                          ? null
                          : () async {
                              await controller.createAccount();
                            },
                    );
                  }),
                  const SizedBox(height: 50),
                  const Center(
                    child: CustomText(
                      text: "Đã có tài khoản",
                      fontSize: 14,
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        await Get.off(() => const LoginScreen());
                        Get.find<RegisterController>().onClose();
                      },
                      child: Column(
                        children: [
                          CustomText(
                            text: "Đăng nhập".toUpperCase(),
                            color: k_primaryColor,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                          const SizedBox(height: 2),
                          Container(
                            width: 30,
                            height: 1.5,
                            color: k_primaryColor,
                          ),
                        ],
                      ),
                    ),
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
