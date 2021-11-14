import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class whoarewe_screen extends StatefulWidget {

  @override
  _whoarewescreenState createState() => new _whoarewescreenState();
}
class _whoarewescreenState extends State<whoarewe_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text( Languages
              .of(context)
              .whoareTitle),
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