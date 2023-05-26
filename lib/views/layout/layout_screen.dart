import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_app_flutter/controller/history/history_booking_controller.dart';
import 'package:travel_app_flutter/controller/home/favorite_controller.dart';
import 'package:travel_app_flutter/controller/layout/layout_controller.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/views/favorite/favorite_screen.dart';
import 'package:travel_app_flutter/views/home/home_screen.dart';
import 'package:travel_app_flutter/views/history/history_booking_screen.dart';
import 'package:travel_app_flutter/views/profile/profile_screen.dart';

import '../../models/user_model.dart';


class LayoutScreen extends GetWidget<LayoutController> {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = MainUser.instance.model!;
    String? uid = userModel.uId;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<LayoutController>(
          builder: (controller) {
            return IndexedStack(
              index: controller.index,
              children: [
                 const HomeScreen(),
                 FavotiteScreen(uid: uid,),
                 HistoryBookingScreen(uid: uid),
                 const ProfileScreen(),
               
              ],
            );
          },
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          color: Colors.white,
          child: GNav(
            onTabChange: controller.onTapChange,
            gap: 10,
            tabBorderRadius: 12,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            tabBackgroundColor: k_primaryColor,
            tabs:  [
              const GButton(
                icon: LineIcons.home,
                text: 'Trang chủ',
              ),
              GButton(
                onPressed: () async {
                    // Get.to(() => FavoriteController(
                    //     ));
                    Get.find<FavoriteController>().results(
                    );
                  },
                icon: LineIcons.heart,
                text: 'Yêu thích',
              ),
              GButton(
                 onPressed: () async {
                    // Get.to(() => FavoriteController(
                    //     ));
                    Get.find<HistoryBookingController>().results(
                    );
                  },
                icon: LineIcons.history,
                text: 'Phòng đã đặt',
              ),
              const GButton(
                icon: LineIcons.user,
                text: 'Hồ sơ',
              )
            ],
          ),
        ),
      ),
    );
  }
}
