

class PlaceToVisit
{
  String? image;
  String? name;

  PlaceToVisit({this.image, this.name});


  PlaceToVisit.fromJson(Map<String, dynamic> json)
  {
    image = json['image'];
    name = json['name'];
  }
}