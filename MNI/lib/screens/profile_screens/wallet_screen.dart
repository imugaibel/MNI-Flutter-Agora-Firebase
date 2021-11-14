import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
class wallet_screen extends StatefulWidget {

  @override
  _walletscreenState createState() => new _walletscreenState();
}
class _walletscreenState extends State<wallet_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(  Languages
              .of(context)
              .wallet2Title),

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