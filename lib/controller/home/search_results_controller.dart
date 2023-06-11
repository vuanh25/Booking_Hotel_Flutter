import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_app_flutter/models/hotel_model.dart';
import 'package:travel_app_flutter/network/firestore_service.dart';

class SearchResultsController extends GetxController {
  bool isLoading = false;
  List<HotelModel> results = [];
  TextEditingController startPriceController = TextEditingController();
  TextEditingController endPriceController = TextEditingController();


  Future<void> searching({
    String? city,
    DateTime? checkIn,
    DateTime? checkOut,
  }) async {
    results = [];
    isLoading = true;
    update();

    var querySnapShot = await FireStoreServic.instance.getHotels();
    var querySnapShot1 = await FireStoreServic.instance.getBookings();
    String? convertCityToLowerCase = city!.toLowerCase();
    for (var element in querySnapShot.docs) {
      String idHotel = element.id;
      bool isAvailable = false;
      for (var element1 in querySnapShot1.docs) {
        String idHotel1 = element1.data()['idHotel'].toString();
        DateTime bookingCheckin = element1.data()['checkIn'].toDate();
        DateTime bookingCheckout = element1.data()['checkOut'].toDate();
        if (idHotel == idHotel1 &&
            bookingCheckin.isBefore(checkOut!) &&
            bookingCheckout.isAfter(checkIn!)) {
              isAvailable = true;
        } 
       
      }
       if(!isAvailable) {
           String convertElementTextToLower =
              element.data()['category'].toString().toLowerCase();
          if (convertElementTextToLower.contains(convertCityToLowerCase)) {
            results.add(HotelModel.fromJson(element.data()));
          }
        }

    }

    isLoading = false;
    update();
  }
}
