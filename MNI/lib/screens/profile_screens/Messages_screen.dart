import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class Messages_screen extends StatefulWidget {

  @override
  _Messages_screenState createState() => new _Messages_screenState();
}
class _Messages_screenState extends State<Messages_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text( Languages
              .of(context)
              .MsgTitle),

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