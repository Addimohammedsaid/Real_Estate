import 'package:firebase_database/firebase_database.dart';
import 'package:real_estate/models/property_details_model.dart';
import 'package:real_estate/models/property_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // Realtime database reference
  final databaseRealtime = FirebaseDatabase.instance.reference();

  // Properties Reference
  final databaseRealtimeProperties =
      FirebaseDatabase.instance.reference().child("properties");

  // Properties Reference
  final databaseRealtimeDetails =
      FirebaseDatabase.instance.reference().child("details");

  Future addNewProperty(Property property, Details details) async {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await databaseRealtimeProperties.child(key).set({
        "key": key,
        "name": property.name,
        "type": property.type ?? " ",
        "city": property.city,
        "area": property.area,
        "price": property.price,
        "imageUrl": property.imageUrl ?? " ",
        "reviews": property.review ?? 0,
        "purpose": property.purpose ?? "SALE",
      });
      await databaseRealtimeDetails.child(key).set({
        "key": key,
        "uid": this.uid,
        "address": details.address,
        "isOwner": details.isOwner,
        "description": details.description,
        "bathrooms": details.bathrooms,
        "bedrooms": details.bedrooms,
        "kitchen": details.kitchen,
        "parking": details.parking,
        "zipCode": details.zipCode,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Get list Property data stream
  Stream<List<Property>> get propertyList {
    return databaseRealtimeProperties.limitToFirst(10).onValue.map((e) {
      return _propertiesListFromSnapshot(e.snapshot);
    });
  }

  // get list Property from map
  List<Property> _propertiesListFromSnapshot(DataSnapshot snapshot) {
    List<Property> list = [];
    var data = snapshot.value;
    for (var k in data.keys) {
      list.add(Property(
        $key: k,
        name: data[k]['name'] ?? " ",
        area: data[k]['area'],
        city: data[k]['city'],
        imageUrl: data[k]['imageUrl'],
        review: data[k]['review'],
        price: data[k]['price'],
        purpose: data[k]['purpose'],
      ));
    }
    return list;
  }

  // Get Property Details
  Stream<Details> propertyDetails(String key) {
    return databaseRealtimeDetails.child(key).onValue.map((e) {
      return _propertyDetailsFromSnapshot(e.snapshot);
    });
  }

  // get Property details from map
  Details _propertyDetailsFromSnapshot(DataSnapshot snapshot) {
    var data = snapshot.value;
    return Details(
        $key: snapshot.key,
        address: data["address"],
        isOwner: data["isOwner"],
        owner: data['owner'],
        bathrooms: data['bathrooms'],
        kitchen: data['kitchen'],
        bedrooms: data['bedrooms'],
        parking: data['parking'],
        description: data['description'],
        zipCode: data['zipCode'],
        phoneNumber: data['phoneNumber']);
  }
}
