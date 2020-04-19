import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Details {
  String $key;
  int zipCode;
  String address;
  bool isOwner = true;
  String owner;
  String description;
  String kitchen;
  String bedrooms;
  String parking;
  String bathrooms;
  String phoneNumber;
  List<String> imagesUrls;
  List<Equipment> equipment;
  Details(
      {this.address,
      this.$key,
      this.phoneNumber,
      this.kitchen,
      this.bathrooms,
      this.bedrooms,
      this.parking,
      this.description,
      this.equipment,
      this.imagesUrls,
      this.isOwner,
      this.owner,
      this.zipCode});
}

class Equipment {
  String type;
  int number;
  IconData icon;
  Equipment({this.number, this.icon, this.type});

  void setNumber(int number) {
    this.number = number;
  }
}

class BedRoom extends Equipment {
  int number;
  BedRoom({this.number})
      : super(
          icon: FontAwesomeIcons.bed,
          type: "BedRoom",
        );
}

class Kitchen extends Equipment {
  int number;
  Kitchen({this.number})
      : super(
          icon: Icons.weekend,
          type: "Kitchen",
        );
}

class BathRoom extends Equipment {
  int number;
  BathRoom({this.number})
      : super(
          icon: FontAwesomeIcons.bath,
          type: "BathRoom",
        );
}

class Parking extends Equipment {
  int number;
  Parking({this.number})
      : super(
          icon: FontAwesomeIcons.parking,
          type: "Parking",
        );
}
