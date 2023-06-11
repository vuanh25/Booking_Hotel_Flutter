

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app_flutter/models/booking_model.dart';

class BookingController extends GetxController
{
  bool isLoading = false;
  
  var checkIn = TextEditingController();
  DateTime? checkInDateTime;
  final checkOut = TextEditingController();
  DateTime? checkOutDateTime;
   final dateFormat = "dd/MM/yyyy";
  BookingModel bookingModel = BookingModel();
  int price = 0;
  int pricePerNight = 0;
    DateRangePickerController? dateController = DateRangePickerController();


    void setDate(var checkin1,var checkout1,int price1,int price2)
    {
      checkIn.text =  DateFormat(dateFormat).format(checkin1 as DateTime);
      checkOut.text =  DateFormat(dateFormat).format(checkout1 as DateTime);
      pricePerNight = price1;
      price = price2;
    }

  Future<void>saveBooking({BookingModel? model}) async {
    
    try{
      isLoading = true;
      final collectionRef = FirebaseFirestore.instance
          .collection('booking')
          .doc("LNgcocf1i8wr1fJKrP2h")
          .collection("bookings");
      final newDocRef = collectionRef.doc();
      
      await newDocRef.set(
        {
          'idBooking': newDocRef.id,
          'idCity': model?.idCity,
          'idHotel': model?.idHotel,
          'idUser': model?.idUser,
          'nameHotel': model?.nameHotel,
          'numPersons': model?.numPersons,
          'numRoms': model?.numRoms,
          'checkIn': model?.checkIn,
          'checkOut': model?.checkOut,
          'price': model?.price,
          'price1': model?.price1,
          'price2': model?.price2,
          'isBooking': model?.isBooking,
          'location': model?.location,
          'image': model?.image,
        }
      );
      isLoading = false;
      update();
      print('added successfully!');
    
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
   
      int numberOfNights = checkOutDateTime!.difference(checkInDateTime!).inDays;
      int newprice = numberOfNights * pricePerNight;
      int price1 =  0;
      price = 0;
      price1 = newprice - price;
      price = newprice;
   
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