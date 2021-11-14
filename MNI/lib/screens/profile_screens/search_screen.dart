import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class search_screen extends StatefulWidget {

  @override
  _searchscreenState createState() => new _searchscreenState();
}
class _searchscreenState extends State<search_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text( Languages
              .of(context)
              .searchTitle),

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