

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/booking_model.dart';
import '../../network/firestore_service.dart';
import '../history/history_booking_controller.dart';

class DetailsBookingController extends GetxController
{
  bool isLoading = false;
  
  var checkIn = TextEditingController();
  DateTime? checkInDateTime;
  final checkOut = TextEditingController();
  DateTime? checkOutDateTime;
   final dateFormat = "dd/MM/yyyy";
  BookingModel bookingModel = BookingModel();
  int price = 0;
  int price1 = 0;
  int price2 = 0;
  int pricePerNight = 0;
  int numberOfNights = 0;
    DateRangePickerController? dateController = DateRangePickerController();

    void setDate(var checkin1,var checkout1,int price_,int price__,int price___)
    {
      checkIn.text =  DateFormat(dateFormat).format(checkin1 as DateTime);
      checkOut.text =  DateFormat(dateFormat).format(checkout1 as DateTime);
     // pricePerNight = price1;
      price = price_;
      price1 = price__;
      price2 = price___;
    }

    


    void getHotelPrice(String idHotel) async
    {
       final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
       .collection("Hotels")
       .doc("yYNuVvpdA3tsA8sjLnAw")
       .collection("NhaTrang").doc(idHotel).get();
       
      if(snapshot.exists)
      {
        final priceData = snapshot.data();
        pricePerNight = priceData!['price'];
      }
      
    }

  Future<void>saveBooking({BookingModel? model}) async {
    
    try{
      isLoading = true;
      update();

      BookingModel model1 = BookingModel(
        idBooking: model?.idBooking,
        idCity: model?.idCity,
        idHotel: model?.idHotel,
        idUser: model?.idUser,
        image: model?.image,
        isBooking: model?.isBooking,
        location: model?.location,
        nameHotel: model?.nameHotel,
        numPersons: model?.numPersons,
        numRoms: model?.numRoms,
        checkIn: model?.checkIn,
        checkOut: model?.checkOut,
        price: model?.price,
        price1: model?.price1,
        price2: model?.price2
      );
      await FireStoreServic.instance.updateBooking(model1);
      isLoading = false;
      update();
      Get.find<HistoryBookingController>().results();
      print('save successfully!');
    
    }
    catch(e)
    {
      print('Error adding : $e');
    }
  }

  Future<void> deleteBooking(BookingModel model) async
  {
    try
    {
      isLoading = true;
      await FireStoreServic.instance.deleteBooking(model);
      isLoading = false;
      update();
      Get.find<HistoryBookingController>().update();
      print('delete successfully!');
    }
    catch(e)
    {
      print('Error adding : $e');
    }

  }





   void onSelectDate(){
    if(dateController?.selectedRange!.startDate == null) return;
    if(dateController?.selectedRange!.endDate == null) return;

    checkInDateTime = dateController?.selectedRange!.startDate;
    checkOutDateTime = dateController?.selectedRange!.endDate;
   
      numberOfNights = checkOutDateTime!.difference(checkInDateTime!).inDays;
      // Sum price
      int newprice = numberOfNights * pricePerNight;
      int sumprice =  0;
      price = 0;
      sumprice = newprice - price;
      price = newprice;
      if(price1 > price)
      {
        price2 = price1 - price; 
      }
      else
      {
          price2 = 0;
      }
       
      
      
      
    checkIn.text = DateFormat(dateFormat).format(dateController?.selectedRange!.startDate as DateTime);
    checkOut.text = DateFormat(dateFormat).format(dateController?.selectedRange!.endDate as DateTime);
    update();
    Get.back();
  }

  void desplay()
  {
    print(dateController?.selectedRange!.startDate);
    print(dateController?.selectedRange!.endDate);
  }

  
}

class HotelPrice {
  final String id;
  final int price;

  HotelPrice({required this.id, required this.price});
}