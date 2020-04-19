import 'package:flutter/material.dart';
import 'package:real_estate/models/property_details_model.dart';
import 'package:real_estate/models/property_model.dart';
import 'package:real_estate/models/user_model.dart';
import 'package:real_estate/services/user_service.dart';
import 'package:real_estate/utils/constant.dart';

class DetailsView extends StatefulWidget {
  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    Property property = ModalRoute.of(context).settings.arguments as Property;

    Details propertyDetails;
    User owner;

    Color favoriteColor =
        user.favorite.contains(property) ? Colors.redAccent : ksecondary;

    Widget _buildImageShowcase() {
      return FractionallySizedBox(
        heightFactor: 0.52,
        widthFactor: 1.0,
        child: Hero(
          tag: property.imageUrl ?? "",
          child: Image.network(
            property.imageUrl ?? "",
            colorBlendMode: BlendMode.darken,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget _buildImageGradient() {
      return FractionallySizedBox(
        heightFactor: 0.52,
        widthFactor: 1.0,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.black54,
                  ],
                  stops: [
                    0.0,
                    1.0
                  ])),
        ),
      );
    }

    Widget _buildInfoBottomLeft() {
      return Positioned(
        left: 40.0,
        bottom: 40.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                color: ksecondary,
                child: Text(
                  "FOR ${property.purpose}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10.0,
            ),
            Text(
              property.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(children: <Widget>[
              Icon(
                Icons.location_on,
                size: 12.0,
                color: Colors.white,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                property.city,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 12.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "${property.area} sq/m",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ],
              ),
            ]),
          ],
        ),
      );
    }

    Widget _buildInfoBottomRight() {
      return Positioned(
          bottom: 40.0,
          right: 30.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (!user.favorite.contains(property)) {
                    user.favorite.add(property);
                    setState(() {
                      favoriteColor = Colors.redAccent;
                    });
                  } else {
                    user.favorite.remove(property);
                    setState(() {
                      favoriteColor = ksecondary;
                    });
                  }
                },
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 15.0,
                      color: favoriteColor,
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: ksecondary,
                    size: 12.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "${property.review} Reviews",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ],
              ),
            ],
          ));
    }

    Widget _buildArrowBack() {
      return Positioned(
        top: 30.0,
        left: 30.0,
        child: Container(
          width: 50.0,
          height: 50.0,
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      );
    }

    Widget _buildInfoProfile() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                child: CircleAvatar(
                  radius: 20.0,
                  //backgroundImage: AssetImage(property.owner.imageUrl) ?? "",
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    owner.name,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Owner",
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.black87,
                  ),
                  child: Icon(Icons.call, size: 15.0, color: Colors.white)),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  print("message");
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.black87,
                  ),
                  child: Icon(
                    Icons.message,
                    size: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }

    _buildInfoIcons() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: propertyDetails.equipment
              .asMap()
              .entries
              .map(
                (MapEntry map) => Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.grey[200],
                        ),
                        child: Icon(
                          propertyDetails.equipment[map.key].icon,
                          color: Colors.black87,
                        )),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${propertyDetails.equipment[map.key].number} ${propertyDetails.equipment[map.key].type}",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
              .toList());
    }

    Widget _buildImageSlideShow(imageUrl) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.all(10.0),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buildImageShowcase(),
                _buildImageGradient(),
                _buildArrowBack(),
                _buildInfoBottomLeft(),
                _buildInfoBottomRight(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: kwhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.0),
                        topRight: Radius.circular(22.0)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        _buildInfoProfile(),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildInfoIcons(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          propertyDetails.description,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Photo",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 200.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: propertyDetails.imagesUrls.length,
                            itemBuilder: (BuildContext context, int index) {
                              String imageUrl =
                                  propertyDetails.imagesUrls[index];
                              return _buildImageSlideShow(imageUrl);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
