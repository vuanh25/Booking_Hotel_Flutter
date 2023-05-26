import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/components/custom_button.dart';
import 'package:travel_app_flutter/components/custom_field.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/controller/auth/login_controller.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/views/auth/register_screen.dart';
import 'package:travel_app_flutter/views/auth/rest_password_screen.dart';


class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var isObsecure = true.obs;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const CustomText(
                  text: "Đăng nhập",
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 30),
                CustomField(
                  hint: "Nhập email",
                  controller: controller.email,
                ),
                const SizedBox(height: 25),
                Obx(() => 
                    CustomField(
                  hint: "Nhập mật khẩu",
                  obscureText: isObsecure.value,
                  suffixIcon: Obx(
                    ()=> GestureDetector(
                      onTap: () {
                        isObsecure.value = !isObsecure.value;
                      },
                      child: Icon(
                         isObsecure.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: k_primaryColor,
                      ),
                    )
                  ),
                 
                  controller: controller.password,
                ),
                ),
              
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const RestPasswordScreen());
                    },
                    child: const CustomText(
                      text: "Quên mật khẩu",
                      color: k_primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                GetBuilder<LoginController>(builder: (controller) {
                  return CustomButton(
                    width: Get.width,
                    text: "Đăng nhập",
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            controller.login();
                          },
                  );
                }),
                const SizedBox(height: 50),
                const Center(
                  child: CustomText(
                    text: "Chưa có tài khoản",
                    fontSize: 14,
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                     Get.off(() => const RegisterScreen());
                    },
                    child: Column(
                      children: [
                        CustomText(
                          text: "Đăng ký tài khoản".toUpperCase(),
                          color: k_primaryColor,
                          fontSize: 14,
                          letterSpacing: 2,
                        ),
                        const SizedBox(height: 2),
                        Container(
                          width: 35,
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
    );
  }
}
