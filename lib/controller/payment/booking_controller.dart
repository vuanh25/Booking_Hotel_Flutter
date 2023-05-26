

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_app_flutter/models/booking_model.dart';

class BookingController extends GetxController
{
  bool isLoading = false;
  
  BookingModel bookingModel = BookingModel();


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
          'idHotel': model?.idHotel,
          'idUser': model?.idUser,
          'numPersons': model?.numPersons,
          'numRoms': model?.numRoms,
          'checkIn': model?.checkIn,
          'checkOut': model?.checkOut,
          'price': model?.price,
          'isBooking': model?.isBooking,
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
}