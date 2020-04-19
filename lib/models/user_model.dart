import 'package:real_estate/models/property_model.dart';

class User {
  String uid;
  String name;
  String imageUrl;
  String city;
  int phoneNumber;
  List<Property> favorite;
  List<Property> owned;
  User({this.name, this.imageUrl, this.city, this.favorite, this.uid});
}
