import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app_flutter/components/custom_button.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/helpers/catch_storage.dart';
import 'package:travel_app_flutter/helpers/constants.dart';
import 'package:travel_app_flutter/models/boarding_model.dart';
import 'package:travel_app_flutter/views/auth/login_screen.dart';


// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController boardingController = PageController();

  int currentIndex = 0;
 

  final List<BoardingModel> items = [
    BoardingModel(
      title: "Tìm những nơi tốt nhất cho bạn",
      subtitle: "",
      image: "assets/images/mountain1.png",
    ),
    BoardingModel(
      title: "Lựa chọn địa điểm đẹp",
      subtitle: "",
      image: "assets/images/destination.png",
    ),
    BoardingModel(
      title: "Đi khắp mọi nơi",
      subtitle: "",
      image: "assets/images/travelling_earth.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.2,
              ),
              SizedBox(
                height: 350,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardingController,
                  itemCount: items.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(
                          items[index].image,
                          width: Get.width / 2,
                        ),
                        const SizedBox(height: 12),
                        CustomText(
                          text: items[index].title.tr,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: Get.width / 1.5,
                          child: CustomText(
                            text: items[index].subtitle.tr,
                            fontSize: 16,
                            color: const Color(0xFFA5A7AC),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SmoothPageIndicator(
                controller: boardingController,
                count: 3,
                axisDirection: Axis.horizontal,
                effect: const ExpandingDotsEffect(
                  spacing: 8.0,
                  radius: 10,
                  dotWidth: 22.0,
                  dotHeight: 12.0,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 1.5,
                  dotColor: Color(0xFFC4C4C4),
                  activeDotColor: k_primaryColor,
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "Tiếp tục",
                onPressed: currentIndex == items.length - 1
                    ? () async {
                        await CatchStorage.save(k_onBoardingKey, true);
                        await Get.off(() => const LoginScreen());
                      }
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
