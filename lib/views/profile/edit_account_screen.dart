import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/build_image.dart';
import '../../components/custom_button.dart';
import '../../components/custom_field.dart';
import '../../components/custom_text.dart';
import '../../controller/profile/edit_account_controller.dart';
import '../../helpers/constants.dart';
import '../../helpers/enum_helper.dart';
import '../../helpers/main_user.dart';
import '../../helpers/validator_helper.dart';

class EditAccountScreen extends GetWidget<EditAccountController> {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Edit Account",
          fontSize: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      GetBuilder<EditAccountController>(builder: (_) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: BuildImage(
                            image: controller.image != null
                                ? controller.image!.path
                                : MainUser.instance.model!.image!,
                            width: 120,
                            height: 120,
                            isNetworkImage: controller.image != null ? false : true,
                          ),
                        );
                      }),
                      // Image.asset(controller.image!.path),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: const CustomText(
                                text: "Choosing picture from :",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomButton(
                                    text: "Gallery",
                                    onPressed: () {
                                      controller.pickImage(ImageSource.gallery);
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  CustomButton(
                                    text: "Camera",
                                    onPressed: () {
                                      controller.pickImage(ImageSource.camera);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: const CustomText(
                          text: "Change Profile Picture",
                          color: k_primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CustomText(
                  text: " ${"Name"}",
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                CustomField(
                  hint: "Name",
                  controller: controller.name,
                  validator: (value) {
                    return ValidatorHelper.instance.validator(value: value, type: FieldType.name);
                  },
                ),
                const SizedBox(height: 15),
                const CustomText(
                  text: " " "Location",
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                CustomField(
                  hint: "Location",
                  controller: controller.location,
                ),
                const SizedBox(height: 15),
                const CustomText(
                  text: " " "Address",
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                CustomField(
                  hint: "Address",
                  controller: controller.address,
                ),
                const SizedBox(height: 15),
                const CustomText(
                  text: " " "Phone Number",
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                CustomField(
                  hint: "Phone Number",
                  controller: controller.phoneNumbner,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return ValidatorHelper.instance
                        .validator(value: value, type: FieldType.phoneNumber);
                  },
                ),
                const SizedBox(height: 30),
                Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  child: CustomButton(
                    text: "Save Changes",
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            controller.onSubmit();
                          },
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
