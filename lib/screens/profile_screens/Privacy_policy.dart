import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class Privacy_policy extends StatefulWidget {

  @override
  _PrivacypolicyState createState() => new _PrivacypolicyState();
}
class _PrivacypolicyState extends State<Privacy_policy> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text( Languages
              .of(context)
              .privTitle),

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