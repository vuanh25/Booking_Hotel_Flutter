import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_app_flutter/models/reviews_model.dart';

import '../../network/firestore_service.dart';


class ListReviewByTypeController extends GetxController{
  bool isLoading = false;
  List<ReviewModel> listReview = [];

  

  Future<void> searching({
    String? idHotel,
  }) async {
    listReview = [];
    isLoading = true;
    update();


    var document = await FireStoreServic.instance.getReviewsHotel();
    String? convertIdHotel = idHotel!.toLowerCase().trim();
    for (var element in document.docs) {
      String converelement = element.data()['idHotel'].toString().toLowerCase();
      if(converelement.contains(convertIdHotel))
      {
        listReview.add(ReviewModel.fromJson(element.data()));
      }
    }
     isLoading = false;
    update();
  }
}
