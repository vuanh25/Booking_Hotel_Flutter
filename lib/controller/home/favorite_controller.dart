
import 'package:get/get.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/models/hotel_model.dart';
import 'package:travel_app_flutter/models/user_model.dart';
import 'package:travel_app_flutter/network/firestore_service.dart';

class FavoriteController extends GetxController
{
  bool isLoading = false;
  List<HotelModel>  listHotel= [];
  UserModel user = MainUser.instance.model!;


  Future<void> results ()async
  {
    listHotel = [];
    isLoading = true;
    update();

    var querySnapShot = await FireStoreServic.instance.getHotels();
    for(var element in querySnapShot.docs)
    {
        String result = element.data()['favoriteByID'].toString();
        if(result.contains(user.uId!))
        {
          listHotel.add(HotelModel.fromJson(element.data()));
        }
        isLoading = false;
        update();
    }
  }
}