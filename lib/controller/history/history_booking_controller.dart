

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_app_flutter/models/booking_model.dart';

import '../../helpers/main_user.dart';
import '../../models/user_model.dart';
import '../../network/firestore_service.dart';

class HistoryBookingController extends GetxController
{
  bool isLoading = false;
  List<BookingModel>  listBooking= [];
  UserModel user = MainUser.instance.model!;


  Future<void> results ()async
  {
    listBooking = [];
    isLoading = true;
    update();

    var querySnapShot = await FireStoreServic.instance.getBookings();
    for(var element in querySnapShot.docs)
    {
        String result = element.data()['idUser'].toString();
        if(result.contains(user.uId!))
        {
          listBooking.add(BookingModel.fromJson(element.data()));
        }
        isLoading = false;
        update();
    }
  }
}