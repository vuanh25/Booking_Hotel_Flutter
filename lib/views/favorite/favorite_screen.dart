


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/controller/home/favorite_controller.dart';

import '../../components/build_search_item.dart';
import '../../components/custom_text.dart';

class FavotiteScreen extends GetWidget<FavoriteController> {
  const FavotiteScreen({Key? key,required this.uid}) : super(key: key);
  final String? uid;
  


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const CustomText(
          text: "Danh sách khách sạn yêu thích",
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
         
          Expanded(
            child: GetBuilder<FavoriteController>(
              builder: ((controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.listHotel.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "Bạn chưa yêu thích phòng nào",
                      maxLines: 2,
                      fontSize: 30,
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    itemCount: controller.listHotel.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 20);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return BuildSearchItem(model: controller.listHotel[index]);
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}