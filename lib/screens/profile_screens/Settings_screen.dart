import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class Settings_screen extends StatefulWidget {

  @override
  _SettingscreenState createState() => new _SettingscreenState();
}
class _SettingscreenState extends State<Settings_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text( Languages
              .of(context)
              .SettingsTitle),

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