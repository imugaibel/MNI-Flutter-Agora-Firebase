import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class Coupons_screen extends StatefulWidget {

  @override
  _CouponscreenState createState() => new _CouponscreenState();
}
class _CouponscreenState extends State<Coupons_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(  Languages
              .of(context)
              .CouponsTitle),

        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ));
  }}