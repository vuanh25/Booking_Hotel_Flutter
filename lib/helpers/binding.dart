
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:travel_app_flutter/controller/auth/register_controller.dart';
import 'package:travel_app_flutter/controller/auth/rest_password_controller.dart';
import 'package:travel_app_flutter/controller/history/history_booking_controller.dart';
import 'package:travel_app_flutter/controller/home/favorite_controller.dart';
import 'package:travel_app_flutter/controller/home/home_controller.dart';
import 'package:travel_app_flutter/controller/home/hotel_details_controller.dart';
import 'package:travel_app_flutter/controller/home/list_review_controller.dart';
import 'package:travel_app_flutter/controller/home/review_controller.dart';
import 'package:travel_app_flutter/controller/layout/layout_controller.dart';
import 'package:travel_app_flutter/controller/payment/booking_controller.dart';

import 'package:travel_app_flutter/controller/profile/edit_account_controller.dart';
import 'package:travel_app_flutter/controller/profile/profile_controller.dart';
import 'package:travel_app_flutter/controller/splash_controller.dart';

import '../controller/auth/login_controller.dart';
import '../controller/home/search_option_controller.dart';
import '../controller/home/search_results_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => SplashController(), fenix: true);
     Get.lazyPut(() => RegisterController(), fenix: true);
     Get.lazyPut(() => LoginController(), fenix: true);
     Get.lazyPut(() => HomeController(), fenix: true);
     Get.lazyPut(() => FavoriteController(),fenix: true);
     Get.lazyPut(() => LayoutController(), fenix: true);
     Get.lazyPut(() => ProfileController(), fenix: true);
     Get.lazyPut(() => EditAccountController(), fenix: true);
     Get.lazyPut(() => SearchResultsController(), fenix: true);
     Get.lazyPut(() => SearchOptionController(), fenix: true);
     Get.lazyPut(() => HotelDetailsController(), fenix: true);
     Get.lazyPut(() => ReviewController(),fenix: true);
     Get.lazyPut(() => ListReviewByTypeController(),fenix: true);
      Get.lazyPut(() => RestPasswordController(),fenix: true);
   
      Get.lazyPut(() => BookingController(),fenix: true);
      Get.lazyPut(() => HistoryBookingController(),fenix: true);
  }
}
