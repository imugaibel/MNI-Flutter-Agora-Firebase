import 'package:flutter/material.dart';
import 'package:mni/localization/language/languages.dart';
import 'package:mni/screens/countrylist.dart';
class Edit_Profil extends StatefulWidget {

  @override
  _EditProfilState createState() => new _EditProfilState();
}
class _EditProfilState extends State<Edit_Profil> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(  Languages
              .of(context)
              .prfTitle),

        ),
        body: Column(
            children: <Widget>[
              Countrylistpick()
            ]
        ));
  }}