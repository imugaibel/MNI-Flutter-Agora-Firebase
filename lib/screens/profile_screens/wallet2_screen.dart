import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class wallet2_screen extends StatefulWidget {

  @override
  _wallet2screenState createState() => new _wallet2screenState();
}
class _wallet2screenState extends State<wallet2_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text( Languages
              .of(context)
              .walletTitle),

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