

class BookingModel
{
  String? idHotel;
  String? idUser;
  int? numPersons;
  int? numRoms;
  DateTime? checkIn;
  DateTime? checkOut;
  int? price; 
  bool? isBooking;
  String? image;

  BookingModel({
    this.idHotel,
    this.idUser,
    this.numPersons,
    this.numRoms,
    this.checkIn,
    this.checkOut,
    this.price,
    this.isBooking,
    this.image
    
  });


  BookingModel.fromJson(Map<String,dynamic> json)
  {
    idHotel = json["idHotel"];
    idUser = json["idUser"];
    numPersons = json["numPersons"];
    numRoms = json["numRoms"];
    checkIn = json["checkIn"].toDate();
    checkOut = json["checkOut"].toDate();
    price = json["price"];
    image = json["image"];
    isBooking = json["isBooking"];
    
  }

  Map<String,dynamic> get toMap
  {
    return 
    {
      'idHotel': idHotel,
      'idUser': idUser,
      'numPersons': numPersons,
      'numRoms': numRoms,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'price': price,
      'isBooking': isBooking,
      'image': image
    };
  }
  
}