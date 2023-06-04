import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app_flutter/models/hotel_model.dart';
import 'package:travel_app_flutter/models/reviews_model.dart';
import 'package:travel_app_flutter/models/user_model.dart';

import '../models/booking_model.dart';

class FireStoreServic {
  FireStoreServic._();

  static final instance = FireStoreServic._();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<HotelModel> hotel_model = [];

  Future<void> saveUser(UserModel model) async {
    await _db.collection("users").doc(model.uId).set(model.toMap);
  }

 



  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uId) async {
    return await _db.collection("users").doc(uId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPopularCategories() async {
    return await _db
        .collection("Cities")
        .doc("xjnS0BPdkAIQ0khiANsA")
        .collection("featureCity")
        .get();
  }




 

  Future<QuerySnapshot<Map<String, dynamic>>> getPlacesToVisit() async {
    return await _db
        .collection("Cities")
        .doc("xjnS0BPdkAIQ0khiANsA")
        .collection("placetovisit")
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getHotels() async {
    return await _db
        .collection("Hotels")
        .doc("yYNuVvpdA3tsA8sjLnAw")
        .collection("NhaTrang")
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getBookings() async {
    return await _db
        .collection("booking")
        .doc("LNgcocf1i8wr1fJKrP2h")
        .collection("bookings")
        .get();
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> getHotelsByID(HotelModel model) async {
    return await _db
        .collection("Hotels")
        .doc("yYNuVvpdA3tsA8sjLnAw")
        .collection("NhaTrang").doc(model.idHotel)
        .get();
  }

  

  

  Future updateHotel(HotelModel hotelModel) async {
    try {
      await _db.collection("Hotels").doc("yYNuVvpdA3tsA8sjLnAw").collection("NhaTrang").doc(hotelModel.idHotel).update(hotelModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getReviewsHotel() async {
    return await _db
        .collection("reviews")
        .doc("XOGm87VMIK0JJRv8AWTB")
        .collection("hotels")
        .get();
  }

  Future<void> updateUser(UserModel model) async {
    return await _db
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .set(model.toMap);
  }
  Future<void> updateBooking(BookingModel model) async {
    return await _db
        .collection("booking")
        .doc("LNgcocf1i8wr1fJKrP2h").collection("bookings")
        .doc(model.idBooking)
        .update(model.toMap);
  }


   Future<void> deleteBooking(BookingModel model) async {
    return await _db
        .collection("booking")
        .doc("LNgcocf1i8wr1fJKrP2h").collection("bookings")
        .doc(model.idBooking)
        .delete();
  }

  Future<bool> postReviewById(ReviewModel model) async {
    try {
      await _db
          .collection("reviews")
          .doc("C21eEa8hgOawFtjVYCrj")
          .set(model.toMap);
      return true;
    } catch (e) {
      print("Error posting review: $e");
      return false;
    }
  }


 
}
