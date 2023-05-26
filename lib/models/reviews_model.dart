

class ReviewModel
{
  String? idHotel;
  String? id;
  String? name;
  String? review;
  String? date;


  ReviewModel({this.idHotel,this.id, this.name, this.review});

  ReviewModel.fromJson(Map<String,dynamic> data)
  {
    idHotel = data["idHotel"];
    id = data["id"];
    name = data["name"];
    review = data["review"];
    date = data["date"];
  }

  Map<String,dynamic> get toMap
  {
    return {
      "idHotel":idHotel,
      "id":id,
      "name":name,
      "review":review,
      "date":date,
    };
  }
  
}