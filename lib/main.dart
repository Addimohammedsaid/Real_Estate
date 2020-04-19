import 'package:flutter/material.dart';
import 'package:real_estate/views/details/details.dart';
import 'views/authenticate/sign_in.dart';
import 'views/home/home.dart';
import 'views/onboarding/onboarding.dart';
import 'views/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xffEABE0B),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      routes: <String, WidgetBuilder>{
        "/wrapper": (BuildContext context) => new Wrapper(),
        "/signIn": (BuildContext context) => new SignIn(),
        "/home": (BuildContext context) => new Home(),
        "/details": (BuildContext context) => new DetailsView(),
      },
      home: OnBoardingScreen(),
    );
  }
}
