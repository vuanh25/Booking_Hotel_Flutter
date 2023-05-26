


import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_app_flutter/models/hotel_model.dart';
import 'package:travel_app_flutter/network/firestore_service.dart';

class SearchResultsController extends GetxController
{
  bool isLoading = false;
  List<HotelModel> results = [];


  


  Future<void> searching({
    String? city,
    DateTime? checkIn,
    DateTime? checkOut,
  }) async 
  {
    results = [];
    isLoading = true;
    update();


    var querySnapShot = await FireStoreServic.instance.getHotels();
    String? convertCityToLowerCase = city!.toLowerCase();
    for (var element in querySnapShot.docs) {
      String convertElementTextToLower = element.data()['category'].toString().toLowerCase();
      if(convertElementTextToLower.contains(convertCityToLowerCase))
      {
        results.add(HotelModel.fromJson(element.data()));
      }
    }

    isLoading = false;
    update();
  }

}