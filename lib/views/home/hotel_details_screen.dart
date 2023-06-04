import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app_flutter/controller/home/hotel_details_controller.dart';
import 'package:travel_app_flutter/controller/home/list_review_controller.dart';
import 'package:travel_app_flutter/controller/payment/booking_controller.dart';
import 'package:travel_app_flutter/helpers/format_ext.dart';
import 'package:travel_app_flutter/views/payment/payment_screen.dart';
import 'package:travel_app_flutter/views/review/list_review_screen.dart';

import '../../components/build_image.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../helpers/constants.dart';
import '../../helpers/main_user.dart';
import '../../models/hotel_model.dart';
import '../../models/user_model.dart';
import '../../network/firestore_service.dart';

class HotelDetailsScreen extends GetWidget<HotelDetailsController> {
  const HotelDetailsScreen({
    Key? key,
    required this.model,
    this.checkIn,
    this.checkOut,
    this.numPerson,
    this.numRoom,
    this.city
  }) : super(key: key);
  final HotelModel model;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? numPerson;
  final int? numRoom;
  final String? city;

  @override
  Widget build(BuildContext context) {
    

    UserModel userModel = MainUser.instance.model!;
    int calculateNumberOfNights(DateTime checkInDate, DateTime checkOutDate) {
    final difference = checkOutDate.difference(checkInDate);
    return difference.inDays;}
  
 
  int numberOfNights = calculateNumberOfNights(checkIn!, checkOut!);
  if (numberOfNights == 0) 
  {
    numberOfNights = 1;
  }
   

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<HotelDetailsController>(
          builder: (controller) {
           
            final isFavorite = controller.isFavorite(userModel.uId!);
          
            
          
            return SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(
                // alignment: Alignment.bottomCenter,
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: model.images!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return BuildImage(
                            image: model.images![itemIndex],
                            height: Get.height * 0.6,
                            width: Get.width,
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          height: Get.height * 0.6,
                          viewportFraction: 1.1,
                          onPageChanged: (int index,
                              CarouselPageChangedReason
                                  carouselPageChangedReason) {
                            controller.onPageChanged(index);
                          },
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 20,
                        child: IconButton(
                          onPressed: () async {
                            if (isFavorite) {
                              controller.removeFavorite(model,userModel.uId!);
                            } else {
                              controller.addFavorite(model,userModel.uId!);
                            
                            }
                            await FireStoreServic.instance
                                .updateHotel(model);
                          },
                          icon: isFavorite
                              ? const Icon(Icons.favorite,
                                  size: 30, color: Colors.red)
                              : const Icon(Icons.favorite_border_outlined,
                                  size: 30, color: Colors.amber),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: Get.height * 0.54,
                        padding: const EdgeInsets.only(bottom: 100),
                        child: AnimatedSmoothIndicator(
                          activeIndex: controller.currentCarouselIndex,
                          count: model.images!.length,
                          effect: const SlideEffect(
                            spacing: 8.0,
                            dotWidth: 13,
                            dotHeight: 13,
                            strokeWidth: 1.5,
                            dotColor: Colors.grey,
                            activeDotColor: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: Get.width,
                      height: Get.height * 0.55,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: model.name!,
                                    maxLines: 2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  Column(
                                    children: [
                                      CustomText(
                                        text: formatCurrency(model.price!),
                                        fontWeight: FontWeight.bold,
                                        color: k_primaryColor,
                                        fontSize: 20,
                                      ),
                                      const CustomText(
                                        text: "/đêm",
                                        fontWeight: FontWeight.bold,
                                        color: k_primaryColor,
                                        fontSize: 20,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  const SizedBox(width: 5),
                                
                                     Row(
                                      children: [
                                         Container(
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: k_primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          
                                          ),
                                           child: CustomText(
                                            text:
                                                "${model.rating}",
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                                                                 ),
                                         ),
                                         const SizedBox(width: 10,),
                                        CustomText(
                                          text:
                                              "(${model.numberOfReviews}  ${'người đánh giá'})",
                                          color: k_fontGray,
                                        ),
                                      ],
                                    ),
                                  
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            height: 45,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.viewDetail.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(width: 25);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.onChangeViewDetail(index);
                                  },
                                  child: Column(
                                    children: [
                                      CustomText(
                                        text: controller.viewDetail[index],
                                        color:
                                            controller.currentViewDetailIndex ==
                                                    index
                                                ? k_primaryColor
                                                : Colors.black,
                                      ),
                                      const SizedBox(height: 3),
                                      if (controller.currentViewDetailIndex ==
                                          index)
                                        const CircleAvatar(
                                          radius: 3,
                                          backgroundColor: k_primaryColor,
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          Expanded(
                            child: _buildDetails(
                              index: controller.currentViewDetailIndex,
                              model: model,
                              checkIn: checkIn!,
                              checkOut: checkOut!,
                            ),
                          ),

                          Row(
                            children: [
                              Expanded(
                                flex: 12,
                                child: Container(
                                  height: 57,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                    border: Border.all(
                                      color: k_primaryColor,
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      Get.to(() => ListReviewScreen(
                                          idHotel: model.idHotel!));
                                      Get.find<ListReviewByTypeController>()
                                          .searching(
                                        idHotel: model.idHotel!,
                                      );
                                    },
                                    child: const Center(
                                      child: CustomText(
                                        text: "Review",
                                        color: k_primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 16,
                                child: CustomButton(
                                  text: "Đặt phòng ngay",
                                  onPressed: () {
                                        Get.to(PaymentScreen(
                                          city: city!,
                                          idHotel: model.idHotel!,
                                          nameHotel: model.name!,
                                          checkIn: checkIn!,
                                          checkOut: checkOut!,
                                          numRoom: numRoom!,
                                          numPerson: numPerson!,
                                          price: model.price!,
                                          address: model.location!,
                                          location: model.location!,
                                          image: model.image!,
                                        ));
                                        Get.find<BookingController>().setDate(checkIn!,checkOut!,model.price!,model.price!*numberOfNights);
                                  },
                                  radius: 70,
                                ),
                              ),
                            ],
                          )
                          // Expanded(child: Row()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _buildDetails extends StatelessWidget {
   const _buildDetails({
    Key? key,
    required this.index,
    required this.model,
    required this.checkIn,
    required this.checkOut,
  }) : super(key: key);
  final int index;
  final HotelModel model;
  final DateTime checkIn;
  final DateTime checkOut;

  @override
  Widget build(BuildContext context) {
    int calculateNumberOfNights(DateTime checkInDate, DateTime checkOutDate) {
  final difference = checkOutDate.difference(checkInDate);
  return difference.inDays;
  }

  
  
 
  int numberOfNights = calculateNumberOfNights(checkIn, checkOut);

   if (numberOfNights == 0) 
  {
    numberOfNights = 1;
  }
    switch (index) {
      case 0: // Overview
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomText(
                  text: model.overview!,
                  textAlign: TextAlign.start,
                  maxLines: 20),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BuildInfoItem(
                    imagePath: "assets/images/duration.png",
                    title: "$numberOfNights ${"Đêm"}",
                    subTitle: "Thơi gian bạn ở lại",
                  ),
                  const SizedBox(height: 10,),
                  _BuildInfoItem(
                    imagePath: "assets/images/Location.png",
                    title: truncateTitle("${model.location} ${"km"}", 35),
                    subTitle: "Địa chỉ khách sạn",
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        );
      case 1: // Details
        return CustomText(text: model.details!);
      // case 2: // Reviews
      //   return CustomText(text: "$numberOfNights");
      // case 2: // Costs
      //   return CustomText(text: model.costs!);
    }
    return CustomText(text: model.overview!);
  }
}

String truncateTitle(String title, int maxLength) {
  if (title.length <= maxLength) {
    return title;
  } else {
    return '${title.substring(0, maxLength)}...';
  }
}

class _BuildInfoItem extends StatelessWidget {
  const _BuildInfoItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: subTitle,
          color: k_fontGray,
          fontSize: 15,
          maxLines: 1,
        ),
        Row(
          children: [
            BuildImage(
              image: imagePath,
              width: 20,
              height: 20,
              isNetworkImage: false,
            ),
            const SizedBox(width: 5),
            CustomText(
              text: title,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
       
      ],
    );
  }
}
