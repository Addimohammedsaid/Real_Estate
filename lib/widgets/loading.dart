import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:real_estate/utils/constant.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kprimary,
      child: Center(
        child: SpinKitPulse(
          color: kwhite,
          size: 50.0,
        ),
      ),
    );
  }
}
