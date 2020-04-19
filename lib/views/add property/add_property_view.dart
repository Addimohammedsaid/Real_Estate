import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/models/property_details_model.dart';
import 'package:real_estate/models/property_model.dart';
import 'package:real_estate/services/database_service.dart';
import 'package:real_estate/utils/constant.dart';

class AddPropertyForms extends StatelessWidget {
  const AddPropertyForms({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Text("Add Property",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20.0,
            ),
            Expanded(child: FormWidget()),
          ],
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  int _stepNumber = 1;

  Property newProperty = Property();
  Details newPropertyDetails = Details();

  List<Equipment> listEquipment = [BedRoom(), BathRoom(), Kitchen(), Parking()];

  List<File> _images = [];
  File _image;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      try {
        _images.add(selected);
      } catch (e) {
        print(e);
      }
    });
  }

  TextEditingController ctrl_name;
  TextEditingController ctrl_adress;
  TextEditingController ctrl_unit;
  TextEditingController ctrl_city;
  TextEditingController ctrl_zipCode;
  TextEditingController ctrl_surface;
  TextEditingController ctrl_price;

  void saveData(BuildContext context) async {
    _formKey.currentState.save();
  }

  void nextPage(int page) {
    setState(() {
      _stepNumber = page;
    });
  }

  Column formOneBuilder(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: ctrl_name,
            validator: (val) => val.length == 0 ? 'Name is required' : null,
            decoration: TextInputDecoration.copyWith(labelText: "Name"),
          ),
          TextFormField(
            validator: (val) => val.length == 0 ? 'Address is required' : null,
            decoration: TextInputDecoration.copyWith(
              labelText: 'Street address *',
            ),
          ),
          TextFormField(
            decoration:
                TextInputDecoration.copyWith(labelText: 'Units# optional'),
          ),
          //TODO :This will become a dropbox with cities
          TextFormField(
            validator: (val) => val.length == 0 ? 'City is required' : null,
            decoration: TextInputDecoration.copyWith(labelText: 'City'),
            onSaved: (val) => newProperty.city = val,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: TextInputDecoration.copyWith(labelText: 'Zip Code'),
            onChanged: (val) => newPropertyDetails.zipCode = int.parse(val),
          ),
          SwitchListTile(
              value: newPropertyDetails.isOwner ?? true,
              title: const Text("owner"),
              activeColor: kprimary,
              onChanged: (value) {
                setState(() {
                  newPropertyDetails.isOwner = value;
                });
              }),
          RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 15.0),
              color: kprimary,
              child: Text(
                'Next',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    saveData(context);
                    nextPage(_stepNumber + 1);
                  });
                }
              }),
        ]);
  }

  Column formTwoBuilder(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (val) => val.length == 0 ? 'Surface is required' : null,
            decoration:
                TextInputDecoration.copyWith(labelText: 'Area Surface in m² *'),
            onSaved: (val) => newProperty.area = double.parse(val) / 1.0,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (val) => val.length == 0 ? 'Price is required' : null,
            decoration:
                TextInputDecoration.copyWith(labelText: 'Set Your Price *'),
            onSaved: (val) => newProperty.price = int.parse(val),
          ),
          Divider(),
          Text(
            "Photos",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          _images.length == 0
              ? Container(
                  width: double.infinity,
                  height: 200.0,
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('No image selected.'),
                      FlatButton(
                        color: kprimary,
                        onPressed: () async => _pickImage(ImageSource.gallery),
                        child: Text(
                          "Add New Photos",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: <Widget>[
                    Container(
                      height: 180.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(10.0),
                        itemCount: _images.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (_images[index] != null)
                            return _buildImageUploads(index);
                          else
                            return Container();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: FlatButton(
                        color: kprimary,
                        onPressed: () async => _pickImage(ImageSource.gallery),
                        child: Text(
                          "Add New Photos",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                  child: Text(
                    'Previous',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400]),
                  ),
                  onPressed: () {
                    setState(() {
                      nextPage(_stepNumber - 1);
                      saveData(context);
                    });
                  }),
              RaisedButton(
                  color: kprimary,
                  child: Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      nextPage(_stepNumber + 1);
                      saveData(context);
                    }
                  }),
            ],
          )
        ]);
  }

  Column formThreeBuilder(context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton<String>(
            isExpanded: true,
            hint: Text(newProperty.type ?? "Choose Home Type"),
            items: <String>['Apartment', 'Multi Family', 'TownHouse', 'Villa']
                .map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                newProperty.type = val;
              });
            },
          ),
          Column(
            children: listEquipment
                .asMap()
                .entries
                .map((MapEntry map) =>
                    _buildListEquipment(listEquipment[map.key]))
                .toList(),
          ),

          // Navigation Button //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                  child: Text(
                    'Previous',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400]),
                  ),
                  onPressed: () {
                    setState(() {
                      nextPage(_stepNumber - 1);
                      saveData(context);
                    });
                  }),
              RaisedButton(
                  color: kprimary,
                  child: Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      saveData(context);
                      await DatabaseService(uid: "122222")
                          .addNewProperty(newProperty, newPropertyDetails);
                    }
                  }),
            ],
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    switch (_stepNumber) {
      case 1:
        return Form(
          key: _formKey,
          child: this.formOneBuilder(context),
        );
        break;

      case 2:
        return Form(
          key: _formKey,
          child: this.formTwoBuilder(context),
        );
        break;

      case 3:
        return Form(
          key: _formKey,
          child: this.formThreeBuilder(context),
        );
        break;
    }
  }

  Widget _buildImageUploads(int index) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Stack(
        children: <Widget>[
          Image.file(_images[index], fit: BoxFit.cover),
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.black,
            ),
            onPressed: () => setState(() {
              _images.removeAt(index);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildListEquipment(Equipment equipment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Icon(
            equipment.icon,
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: TextInputDecoration.copyWith(
                  hintText: "Number of " + equipment.type),
              validator: (val) => val.length <= 0 ? 'Field is empty' : null,
              onChanged: (val) {
                if (equipment.type == "Kitchen")
                  newPropertyDetails.kitchen = val;
                if (equipment.type == "BathRoom")
                  newPropertyDetails.bathrooms = val;
                if (equipment.type == "BedRoom")
                  newPropertyDetails.bedrooms = val;
                if (equipment.type == "Parking")
                  newPropertyDetails.parking = val;
                print(newPropertyDetails.bathrooms);
              },
            ),
          ),
        ],
      ),
    );
  }
}
