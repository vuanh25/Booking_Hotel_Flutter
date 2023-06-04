import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_app_flutter/components/build_image.dart';
import 'package:travel_app_flutter/components/build_search_item.dart';
import 'package:travel_app_flutter/components/custom_field.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/controller/home/home_controller.dart';
import 'package:travel_app_flutter/helpers/constants.dart';

import 'package:travel_app_flutter/views/home/search_option_screen.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                width: Get.width,
                child: SingleChildScrollView(
                  
                  child: Column(
                   
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(LineIcons.bars),
                          Icon(LineIcons.bell),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: const CustomText(
                          text: "Hôm nay bạn muốn đi đâu?",
                          maxLines: 3,
                          fontSize: 28,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(85),
                        child: GestureDetector(
                          onTap: () async =>
                              await Get.to(() =>  const SearchOptionScreen()),
                          child: CustomField(
                            enabled: false,
                            hint: "Tìm nơi ở cho bạn".tr,
                            fillColor: k_fieldGray,
                            radius: 85,
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(10),
                              child: const CircleAvatar(
                                backgroundColor: k_primaryColor,
                                child:
                                    Icon(LineIcons.search, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        text: "Những nơi phổ biến",
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 100,
                        child: ListView.separated(
                          itemCount: controller.popularCategory.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 40);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              // onTap: () => Get.to(
                              //   () => TourDetailsScreen(
                              //     model: controller.tours[index],
                              //   ),
                              // ),
                              onTap: () => Get.to(
                                () => SearchOptionScreen(
                                  name: controller.popularCategory[index].name!,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: BuildImage(
                                      image: controller
                                          .popularCategory[index].image!,
                                      borderRadius: 30,
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  CustomText(
                                      text: controller
                                          .popularCategory[index].name!),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                       const CustomText(
                        text: "Những nơi tham quan phổ biến",
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.placeToVisit.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 20);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: GestureDetector(
                                child: Stack(
                                  children: [
                                    BuildImage(
                                      image:
                                          controller.placeToVisit[index].image!,
                                      borderRadius: 25,
                                      width: 205,
                                      height: 250,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        width: Get.width,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black45,
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: controller
                                                      .placeToVisit[index]
                                                      .name!,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const CustomText(
                        text: "Những khách sạn phổ biến",
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      const SizedBox(height: 10),
                      ///////////////////////////////////////
                       SizedBox(
                        height: Get.height * 0.5,
                         child: ListView.separated(
                       
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                width: 20,
                                height: 10,
                              );
                            },
                            itemCount: controller.hotelModel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => Get.to(
                                  () => const SearchOptionScreen()
                                ),
                                child: BuildSearchItem(model: controller.hotelModel[index],),
                              
                              );
                            },
                          ),
                       ),
               
                    ],
                  ),
                ),
              );
      },
    );
  }
}
