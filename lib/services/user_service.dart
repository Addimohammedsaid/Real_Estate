import 'package:firebase_database/firebase_database.dart';
import 'package:real_estate/models/user_model.dart';

User user = User(
    imageUrl: "assets/img/p1.jpg", name: "Roman", city: "Paris", favorite: []);

class UserService {
  // initiate the user object
  User currentUser;

  UserService({this.currentUser});

  // Reference to the firebase database
  final userDatabaseReference =
      FirebaseDatabase.instance.reference().child("users");

  // Get Property Details
  Stream<User> getUserFromUid(String uid) {
    return userDatabaseReference.child(uid).onValue.map((e) {
      return _getUserFromSnapshot(e.snapshot);
    });
  }

  // get Property details from map
  User _getUserFromSnapshot(DataSnapshot snapshot) {
    var data = snapshot.value;
    return User(
      uid: snapshot.key,
      name: data['name'],
    );
  }
}
