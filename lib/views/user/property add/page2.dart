import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/models/property_features_model.dart';
import 'package:real_estate/models/property_model.dart';
import 'package:real_estate/utils/constant.dart';

class AddPropertyPage2 extends StatefulWidget {
  final Function changePages;
  final Function updateProperty;
  Property newProperty;

  AddPropertyPage2({this.newProperty, this.changePages, this.updateProperty});

  @override
  _AddPropertyPage2State createState() => _AddPropertyPage2State();
}

class _AddPropertyPage2State extends State<AddPropertyPage2> {
  final _formKey = GlobalKey<FormState>();
  Features newPropertyFeatures = Features();
  String error = " ";
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration:
                  TextInputDecoration.copyWith(hintText: 'Area Surface in m²*'),
              onChanged: (val) {
                setState(() {
                  widget.newProperty.area = double.parse(val);
                });
              },
            ),
            TextFormField(
              decoration:
                  TextInputDecoration.copyWith(hintText: 'Set Your Price*'),
              onChanged: (val) {
                setState(() {
                  widget.newProperty.price = int.parse(val);
                });
              },
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
                          onPressed: () async =>
                              _pickImage(ImageSource.gallery),
                          child: Text(
                            "Add New Photos",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 150.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400])),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('No image selected.'),
                                SizedBox(
                                  height: 20.0,
                                ),
                                FlatButton(
                                  color: kprimary,
                                  onPressed: () async =>
                                      _pickImage(ImageSource.gallery),
                                  child: Text(
                                    "Add New Photos",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Stack(
                          children: <Widget>[
                            Image.file(_images[index - 1],
                                width: 150.0, height: 150.0),
                            Container(
                              width: 150.0,
                              height: 50.0,
                              color: Colors.black45,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(
                                  width: 10.0,
                                ),
                                index == 1
                                    ? Text(
                                        "Main Photo",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Text(""),
                                SizedBox(
                                  width: 30.0,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () => setState(() {
                                    _images.removeAt(index - 1);
                                  }),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
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
                      widget.updateProperty(widget.newProperty);
                      widget.changePages(1);
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        widget.updateProperty(widget.newProperty);
                        widget.changePages(3);
                      }
                    }),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ]),
    );
  }
}
