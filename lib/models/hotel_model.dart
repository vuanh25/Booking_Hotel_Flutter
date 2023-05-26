

class HotelModel
{
  String? idHotel;
  String? name;
  String? image;
  String? location;
  List<String>? images;
  String? category;
  String? details;
  int? numberOfReviews;
  double? rating;
  int? price;
  String? overview;
  int? durationDay;
  List<String>? favoriteByID;

  HotelModel({
    this.idHotel,
    this.name,
    this.image,
    this.images,
    this.category,
    this.numberOfReviews,
    this.rating,
    this.price,
    this.durationDay,
    this.location,
    this.overview,
    this.favoriteByID
  });

  HotelModel.fromJson(Map<String, dynamic> json) {
    idHotel = json['idHotel'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    overview = json['overview'];
    images = json['images'].cast<String>();
    rating = json['rating'];
    numberOfReviews = json['number_of_reviews'];
    location = json['location'];
    durationDay = json['duration_day'];
    category = json['category'];
    favoriteByID = json['favoriteByID'].cast<String>();
  }

   Map<String, dynamic> toMap() {
    return {
      'idHotel': idHotel,
      'image': image,
      'name': name,
      'price': price,
      'overview': overview,
      'images': images,
      'rating': rating,
      'number_of_reviews': numberOfReviews,
      'location': location,
      'duration_day': durationDay,
      'category': category,
      'favoriteByID': favoriteByID,
    };
  }


}