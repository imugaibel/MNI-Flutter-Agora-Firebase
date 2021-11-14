import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class ask_help extends StatefulWidget {

  @override
  _askhelpStateState createState() => new _askhelpStateState();
}
class _askhelpStateState extends State<ask_help> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text( Languages
              .of(context)
              .HelpTitle ),

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