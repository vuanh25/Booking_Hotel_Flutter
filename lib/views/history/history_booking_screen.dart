import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app_flutter/controller/history/history_booking_controller.dart';
import 'package:travel_app_flutter/controller/home/details_booking_controller.dart';
import 'package:travel_app_flutter/helpers/format_ext.dart';
import 'package:travel_app_flutter/models/booking_model.dart';
import 'package:travel_app_flutter/views/home/details_booking_screen.dart';
import '../../components/build_image.dart';
import '../../components/custom_text.dart';

class HistoryBookingScreen extends GetWidget<HistoryBookingController> {
  const HistoryBookingScreen({Key? key, this.uid}) : super(key: key);
  final String? uid;

  Widget buildCard({required BookingModel model}) {
    return GestureDetector(
      onTap: () {
        Get.to( DetailsBookingScreen(model: model,));
        Get.find<DetailsBookingController>().setDate(model.checkIn, model.checkOut, model.price!,model.price1 == null ? 0 : model.price1!,model.price2 == null ? 0 : model.price2!,);
        Get.find<DetailsBookingController>().getHotelPrice(model.idHotel!);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BuildImage(
                image: model.image!,
                height: 380,
                width: Get.width,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.nameHotel!,
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const Row(
                  children: [
                    //  Text(model.price!.toString(),
                    //     style: const TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //     ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatCurrency(model.price!),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  model.isBooking == true ? "Đã thanh toán" : "Chưa thanh toán",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text("Lịch sử đặt phòng"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<HistoryBookingController>(
              builder: ((controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.listBooking.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "Bạn chưa đặt phòng nào cả",
                      maxLines: 2,
                      fontSize: 25,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      itemCount: controller.listBooking.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 20);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return buildCard(model: controller.listBooking[index]);
                      },
                    ),
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
