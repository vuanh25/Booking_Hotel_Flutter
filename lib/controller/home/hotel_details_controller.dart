


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_app_flutter/helpers/main_user.dart';
import 'package:travel_app_flutter/models/hotel_model.dart';
import 'package:travel_app_flutter/models/user_model.dart';







class HotelDetailsController extends GetxController 
{
  int currentCarouselIndex = 0;
  int currentViewDetailIndex = 0;
  
  List<HotelModel> list = [];
  HotelModel model = HotelModel();
  UserModel user = MainUser.instance.model!; 
  final List<String> favoriteIDs = [];

  List<String> viewDetail = 
  [
    "Tổng quan về phòng",
    // "Details",
    // "Costs",
  ];

  

  late String viewValue;
  
  @override
  void onInit()  async{
    // TODO: implement onInit
    super.onInit();
    viewValue = viewDetail[currentViewDetailIndex]; 
  
    
  }

  Future<void> results(String idHotel) async
  {
    list = [];
    var documentSnapshot = await FirebaseFirestore.instance
    .collection('Hotels')
    .doc("yYNuVvpdA3tsA8sjLnAw")
    .collection("NhaTrang")
    .doc(idHotel)
    .get();
    if (documentSnapshot.exists) {
    List<String> idFavorites = List<String>.from(
      documentSnapshot.data()!['favoriteByID'] ?? []); 
      favoriteIDs.addAll(idFavorites);
  }
  }

  bool isFavorite(String uId) 
  {
    
    if(favoriteIDs.contains(uId)) {
      return true;
    } else {
      return  false;
    }
     
  }

  void addFavorite(HotelModel model,String uId) async {
    favoriteIDs.add(uId);
    model.favoriteByID!.add(uId);
    update(); 
  }

   void removeFavorite(HotelModel model,String uId) async{
    favoriteIDs.remove(uId);
    model.favoriteByID!.remove(uId);
    update();
     
  }



  void onPageChanged(int newIndex)
  {
    currentCarouselIndex = newIndex;
    
    update();
  }


  void onChangeViewDetail(int newIndex)
  {
    currentViewDetailIndex = newIndex;
    viewValue = viewDetail[currentViewDetailIndex];
    update();
  }

  

  





  

  

 
}


