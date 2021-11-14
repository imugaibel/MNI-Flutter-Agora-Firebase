import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class Application_Policy extends StatefulWidget {

  @override
  _ApplicationPolicyState createState() => new _ApplicationPolicyState();
}
class _ApplicationPolicyState extends State<Application_Policy> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Languages
              .of(context)
              .AppPolyTitle ),

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