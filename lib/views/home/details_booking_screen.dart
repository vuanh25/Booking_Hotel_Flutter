import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app_flutter/components/buid_dialog.dart';
import 'package:travel_app_flutter/controller/history/history_booking_controller.dart';
import 'package:travel_app_flutter/controller/home/details_booking_controller.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/models/booking_model.dart';
import 'package:travel_app_flutter/models/user_model.dart';
import 'package:travel_app_flutter/views/layout/layout_screen.dart';

import '../../components/alert_date.dart';
import '../../components/custom_button.dart';
import '../../components/custom_field.dart';
import '../../components/custom_text.dart';
import '../../helpers/constants.dart';
import '../../helpers/format_ext.dart';

class DetailsBookingScreen extends GetWidget<DetailsBookingController> {
  const DetailsBookingScreen({super.key, required this.model});
  final BookingModel model;
  final bool check = false;
  @override
  Widget editPricr(BookingModel model) {
    return Column(
      children: [
        if (model.isBooking == true)
          CustomText(
            text: "Số tiền đã thanh toán:  ${formatCurrency(model.price as int)}",
            color: Colors.white,
          )
      ],
    );
  }

 

  @override
  Widget build(BuildContext context) {
    UserModel user = MainUser.instance.model!;
    int calculateRemainingAmount(int totalAmount, int amountPaid) {
  if (totalAmount == amountPaid) {
    return 0;
  } else if (totalAmount > amountPaid) {
    return 0;
  } else {
    return amountPaid - totalAmount; 
  }
}




    return GetBuilder<DetailsBookingController>(builder: (controller) {
      
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title:  const Text("Thông tin chi tiết"),
          ),
          body: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: Get.width,
              decoration:  const BoxDecoration(
                  color: k_primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: "Tên khách hàng: ${user.name}",
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "Thành phố: ${model.idCity}",
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "Tên khách sạn: ${model.nameHotel}",
                      color: Colors.white,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: " ${"Ngày nhận phòng"}",
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDate(
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    DateRangeContoller:
                                        controller.dateController,
                                    onPressed: () {
                                      controller.onSelectDate();
                                      controller.desplay();
                                    },
                                  );
                                },
                              );
                            },
                            child: CustomField(
                              enabled: false,
                              hint: controller.checkIn.text,
                              fillColor: k_fieldGray,
                              prefixIcon: const Icon(LineIcons.calendar),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: " ${"Ngày trả phòng"}",
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDate(
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    DateRangeContoller:
                                        controller.dateController,
                                    onPressed: () {
                                      controller.onSelectDate();
                                      controller.desplay();
                                    },
                                  );
                                },
                              );
                            },
                            child: CustomField(
                              enabled: false,
                              hint: controller.checkOut.text,
                              fillColor: k_fieldGray,
                              prefixIcon: const Icon(LineIcons.calendar),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: "Số phòng: ${model.numRoms}",
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "Số người: ${model.numPersons}",
                      color: Colors.white,
                    ),
                    Text(
                      "Địa chỉ: ${model.location}",
                      style: const TextStyle(fontSize: 17, color: Colors.white),
                    ),
                      CustomText(
                      text: "Số tiền đã thanh toán:  ${model.isBooking == true?formatCurrency(model.price1 as int) : 0}",
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "Tổng tiền:  ${formatCurrency(controller.price)}",
                      color: Colors.white,
                    ),
                   
                    CustomText(
                      text:
                          "Số tiền dư trả lại khách:  ${formatCurrency(controller.price2)}",
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomButton(
                        onPressed: () {
                          model.idBooking = model.idBooking;
                          if (controller.checkInDateTime != null &&
                              controller.checkOutDateTime != null) {
                            model.checkIn = controller.checkInDateTime;
                            model.checkOut = controller.checkOutDateTime;
                          }
                          model.checkIn = model.checkIn;
                          model.checkOut = model.checkOut;
                          model.price = controller.price;
                          model.price1 = model.price1;
                          model.price2 = controller.price2;
                          controller.saveBooking(model: model);
                          Get.back();
                          Get.snackbar(
                            "Thông báo",
                            "Lưu thành công",
                          );
                          //   Get.find<HistoryBookingController>().update();
                        },
                        text: "Xác nhận lưu thay đổi",
                        color: Colors.greenAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CleanDialog(
                              title: 'Xác nhận',
                              content: 'Bạn có chắc muốn huỷ đặt phòng.',
                              backgroundColor: k_primaryColor,
                              titleTextStyle: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              contentTextStyle: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                              actions: [
                                CleanDialogActionButtons(
                                  actionTitle: 'Quay lại',
                                  textColor: Colors.red,
                                  onPressed: () => Navigator.pop(context),
                                ),
                                CleanDialogActionButtons(
                                  actionTitle: 'Xác nhận',
                                  textColor: const Color(0XFF27ae61),
                                  onPressed: () {
                                    Get.offAll(const LayoutScreen());
                                    Get.find<DetailsBookingController>()
                                        .deleteBooking(model);
                                    Get.find<HistoryBookingController>()
                                        .results();
                                    // Get.find<HistoryBookingController>().update();
                                    Get.snackbar(
                                      "Thông báo",
                                      "Huỷ thành công",
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        text: "Huỷ đặt phòng",
                        color: Colors.greenAccent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
