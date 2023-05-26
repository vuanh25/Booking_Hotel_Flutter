



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/components/build_image.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/views/profile/edit_account_screen.dart';

import '../../controller/profile/profile_controller.dart';

class ProfileScreen extends GetWidget<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            GetBuilder<ProfileController>(
              builder: (_) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: BuildImage(
                    image: MainUser.instance.model!.image!,
                    width: 120,
                    height: 120,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            GetBuilder<ProfileController>(
              builder: (_) {
                return CustomText(
                  text: MainUser.instance.model!.name!,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                );
              },
            ),
            const SizedBox(height: 30),
             _BuildItem(
              title: "Chỉnh sữa tài khoản",
              leadingIcon: Icons.settings,
              sufixIcon: Icons.arrow_forward_ios,
             onTap: () => Get.to(() => const EditAccountScreen()),
            ),
            const SizedBox(height: 25),
            const _BuildItem(
              title: "Thêm thẻ ngân hàng",
              leadingIcon: Icons.add,
              sufixIcon: Icons.arrow_forward_ios,
             // onTap: () => Get.to(() => AddCardScreen()),
            ),
            // const SizedBox(height: 25),
            // _BuildItem(
            //   title: "Account Security",
            //   leadingIcon: Icons.lock_open,
            //   sufixIcon: Icons.arrow_forward_ios,
            //   onTap: () {},
            // ),
            const SizedBox(height: 25),
            _BuildItem(
              title: "Trợ giúp",
              leadingIcon: Icons.help_outline,
              sufixIcon: Icons.arrow_forward_ios,
              onTap: () {},
            ),
           
            const SizedBox(height: 25),
            _BuildItem(
              title: "Đăng xuất",
              leadingIcon: Icons.logout,
              sufixIcon: Icons.arrow_forward_ios,
              onTap: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({
    Key? key,
    this.onTap,
    required this.title,
    required this.leadingIcon,
    this.sufixIcon,
  }) : super(key: key);
  final void Function()? onTap;
  final String title;
  final IconData leadingIcon;
  final IconData? sufixIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(leadingIcon, color: k_primaryColor, size: 30),
          const SizedBox(width: 20),
          Expanded(
            child: CustomText(
              text: title,
              fontSize: 18,
              textAlign: TextAlign.start,
            ),
          ),
          if (sufixIcon != null) Icon(sufixIcon, color: k_buttonGray, size: 20),
        ],
      ),
    );
  }
}
