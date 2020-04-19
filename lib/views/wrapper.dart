import 'package:flutter/material.dart';
import 'package:real_estate/utils/constant.dart';
import 'package:real_estate/views/favorite/favorite.dart';
import 'package:real_estate/views/home/home.dart';
import 'add property/add_property_view.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  final String user = "user";
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Authenticate();
    } else
      return NavigationWrapper();
  }
}

class NavigationWrapper extends StatefulWidget {
  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _index = 0;

  static List<Widget> _widgetOption = <Widget>[
    Home(),
    Favorite(),
    AddPropertyForms(),
  ];

  void _getNewIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kprimary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
        ],
        currentIndex: _index,
        onTap: _getNewIndex,
      ),
      body: _widgetOption.elementAt(_index),
    );
  }
}
