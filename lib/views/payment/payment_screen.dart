

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app_flutter/components/custom_button.dart';
import 'package:travel_app_flutter/components/custom_text.dart';
import 'package:travel_app_flutter/controller/payment/booking_controller.dart';
import 'package:travel_app_flutter/helpers/format_ext.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/models/booking_model.dart';
import 'package:travel_app_flutter/models/user_model.dart';
import 'package:travel_app_flutter/views/history/history_booking_screen.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

import '../../controller/history/history_booking_controller.dart';
import '../../helpers/constants.dart';

class PaymentScreen extends GetWidget<BookingController>
{
  const PaymentScreen({ 
    Key? key,
    required  this.nameHotel,
    required  this.checkIn,
    required  this.checkOut,
    required  this.numRoom,
    required  this.numPerson,
    required  this.address,
    required  this.price,
    required  this.idHotel,
    required this.image
     }) : super(key: key);
  final String nameHotel;
  final DateTime checkIn;
  final DateTime checkOut;
  final int numRoom;
  final int numPerson;
  final String address;
  final int price;
  final String idHotel;
  final String image;
  @override
  Widget build(BuildContext context) {
     final formatCheckin = DateFormat('dd/MM/yyyy').format(checkIn);
     final formatCheckout = DateFormat('dd/MM/yyyy').format(checkOut);
     UserModel user = MainUser.instance.model!;
     String responseCode = "";
     double price1 = price.toDouble();
     BookingModel model = BookingModel();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: const Text("Thông tin thanh toán"),
        ),
        body: GetBuilder<BookingController>(
          builder: (controller){
             void onPayment() async
     {
      final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
        url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
        version: '2.0.1', 
        tmnCode: 'O9U5ZOOF', 
        txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: price1 , 
        orderInfo: price.toString(),
        returnUrl: 'http://localhost:3000/return', 
        ipAdress: '192.168.0.105', 
        vnpayHashKey: 'MLGFYWGJOCEEFNMAYUQKDIRPYIXIDRMQ',
        vnPayHashType: VNPayHashType
          .HMACSHA512,

        );
              
        VNPAYFlutter.instance.show(
          paymentUrl: paymentUrl, 
          onPaymentSuccess: (queryParameters) {
          if (queryParameters['vnp_ResponseCode'] == '00') {
            responseCode = queryParameters['vnp_ResponseCode']!;
              model.idHotel = nameHotel;
              model.idUser = user.uId;
              model.checkIn = checkIn;
              model.checkOut = checkOut;
              model.numPersons = numPerson;
              model.numRoms = numRoom;
              model.image = image;
              model.price = price1.toInt();
              model.isBooking = true;
             controller.saveBooking(model: model);
            Get.snackbar("Thông báo", "Thanh toán thành công", );
            Get.to( const HistoryBookingScreen());
             Get.find<HistoryBookingController>().results();
       
            
          } else {
            responseCode = queryParameters['vnp_ResponseCode']!;
            Get.snackbar("Thông báo", "Thanh toán thất bại",);
          }
        }
        );
     }

            return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: k_primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(text: "Tên khách hàng: ${user.name}",fontSize: 20,color: Colors.white,),
                    CustomText(text: "Tên khách sạn: $nameHotel",fontSize: 20,color: Colors.white,),
                    CustomText(text: "Ngày đến: $formatCheckin",fontSize: 20,color: Colors.white,),
                    CustomText(text: "Ngày đi: $formatCheckout",fontSize: 20,color: Colors.white,),
                    CustomText(text: "Số phòng: $numRoom",fontSize: 20,color: Colors.white,),
                    CustomText(text: "Số người: $numPerson",fontSize: 20,color: Colors.white,),
                    Text("Địa chỉ: $address",style: const TextStyle(fontSize: 17,color: Colors.white),),
                    CustomText(text: "Tổng tiền:  ${formatCurrency(price)}",fontSize: 20,color: Colors.white,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: CustomButton(
                        onPressed: ()=> onPayment(),
                        text: "Thanh toán",color: Colors.greenAccent,
                        ),
                    )
                  ],
                ),
              ),
            ),
          );
          },
      
        ),
        
      ),
    );
  }


  
}







