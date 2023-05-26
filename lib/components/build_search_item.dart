import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/controller/home/hotel_details_controller.dart';
import 'package:travel_app_flutter/helpers/format_ext.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/models/user_model.dart';
import 'package:travel_app_flutter/views/home/search_option_screen.dart';

import '../helpers/constants.dart';
import '../models/hotel_model.dart';
import '../views/home/hotel_details_screen.dart';
import 'build_image.dart';
import 'custom_text.dart';


class BuildSearchItem extends StatelessWidget {
  final HotelModel model;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? numPerson;
  final int? numRoom;
  const BuildSearchItem({
    Key? key,
    required this.model,
    this.checkIn,
    this.checkOut,
    this.numPerson,
    this.numRoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = MainUser.instance.model!;
    return GestureDetector(
     onTap: () {
     checkIn == null || checkOut == null || numPerson == null || numRoom == null
      ? Get.to(const SearchOptionScreen())
      :
     Get.to(() => HotelDetailsScreen(
      model: model,
      checkIn: checkIn,
      checkOut: checkOut,
      numPerson: numPerson,
      numRoom: numRoom,
      ));

      Get.find<HotelDetailsController>().results(model.idHotel!);
     },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BuildImage(
              image: model.image!,
              height: 140,
              width: Get.width,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: model.name!, fontWeight: FontWeight.w600),
                CustomText(text: formatCurrency(model.price!), fontWeight: FontWeight.w600),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                  
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: k_primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "${model.rating}",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    text: "(${model.numberOfReviews} ${("reviews")})",
                    color: k_fontGray,
                    fontSize: 14,
                  ),
                ],
              ),
              CustomText(
                text: "/night",
                color: k_fontGray,
                fontSize: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}
