

class BookingModel
{
  String? idBooking;
  String? idHotel;
  String? idCity;
  String? idUser;
  String? nameHotel;
  String? location;
  int? numPersons;
  int? numRoms;
  DateTime? checkIn;
  DateTime? checkOut;
  int? price; 
  int? price1;
  int? price2;
  bool? isBooking;
  String? image;

  BookingModel({
    this.idBooking,
    this.idCity,
    this.location,
    this.idHotel,
    this.idUser,
    this.nameHotel,
    this.numPersons,
    this.numRoms,
    this.checkIn,
    this.checkOut,
    this.price,
    this.price1,
    this.price2,
    this.isBooking,
    this.image,
  
    
  });


  BookingModel.fromJson(Map<String,dynamic> json)
  {
    idBooking = json["idBooking"];
    idCity = json["idCity"];
    idHotel = json["idHotel"];
    idUser = json["idUser"];
    nameHotel = json["nameHotel"];
    numPersons = json["numPersons"];
    numRoms = json["numRoms"];
    checkIn = json["checkIn"].toDate();
    checkOut = json["checkOut"].toDate();
    price = json["price"];
    price1 = json["price1"];
    price2 = json["price2"];
    image = json["image"];
    location = json["location"];
    isBooking = json["isBooking"];
    
  }

  Map<String,dynamic> get toMap
  {
    return 
    {
      'idBooking': idBooking,
      'idCity': idCity,
      'idHotel': idHotel,
      'idUser': idUser,
      'nameHotel': nameHotel,
      'numPersons': numPersons,
      'numRoms': numRoms,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'price': price,
      'price1': price1,
      'price2': price2,
      'isBooking': isBooking,
      'image': image,
      'location': location
    };
  }
  
}