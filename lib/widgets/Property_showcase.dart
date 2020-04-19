import 'package:flutter/material.dart';
import 'package:real_estate/models/property_model.dart';
import 'package:real_estate/utils/constant.dart';

class BuildPropertyShowcase extends StatelessWidget {
  final Property property;

  BuildPropertyShowcase(this.property);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, "/details", arguments: property),
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 200.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(-3.0, 3.0),
                blurRadius: 10.0,
              )
            ]),
        child: Stack(
          children: <Widget>[
            FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: Hero(
                tag: property.imageUrl ?? "",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    property.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 15.0,
                left: 15.0,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    color: ksecondary,
                    child: Text(
                      "FOR ${property.purpose ?? ""}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ))),
            Positioned(
              left: 10.0,
              bottom: 12.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    property.name ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 10.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      property.city,
                      style: TextStyle(
                        fontSize: 12.0,
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
                          size: 10.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "${property.area ?? ""} sq/m",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
            ),
            Positioned(
                bottom: 12.0,
                right: 25.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      "\$${property.price ?? ""}.00",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: ksecondary,
                          size: 10.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "${property.review ?? ""} Reviews",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
