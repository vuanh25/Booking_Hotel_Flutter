
import 'package:get/get.dart';
import 'package:travel_app_flutter/models/category_model.dart';
import 'package:travel_app_flutter/models/hotel_model.dart';
import 'package:travel_app_flutter/models/places_to_visit_model.dart';
import 'package:travel_app_flutter/network/firestore_service.dart';

class HomeController extends GetxController
{
  bool isLoading = false;
  // List<String> Cities = [];
  List<CategoryModel> popularCategory = [];
  List<PlaceToVisit> placeToVisit = [];
  List<HotelModel> hotelModel = [];
 
  int currentIndex = 0;

  @override
  onInit() async
  {
    super.onInit();
    isLoading = true;
    update();

    await getPopularCategory();
    await getPlaceToVisit();
    await getHotelModel();

    isLoading = false;
    update();

   
  }

  Future<void> getPopularCategory() async
  {
    popularCategory = [];
    var querySnapShot = await FireStoreServic.instance.getPopularCategories();

    for (var element in querySnapShot.docs) {
      popularCategory.add(CategoryModel.fromJson(element.data()));
    }
    update();
  }

  Future<void> getPlaceToVisit() async
  {
    placeToVisit = [];
    var querySnapShot = await FireStoreServic.instance.getPlacesToVisit();

    for (var element in querySnapShot.docs) {
      placeToVisit.add(PlaceToVisit.fromJson(element.data()));
    }
    update();
  }

  Future<void> getHotelModel() async
  {
    hotelModel = [];
    var querySnapShot = await FireStoreServic.instance.getHotels();
    for(var element in querySnapShot.docs)
    {
      hotelModel.add(HotelModel.fromJson(element.data()));
    }
    update();
  }
  
}