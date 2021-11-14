import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

class Countrylistpick extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: CountryListPick(
        theme: CountryTheme(
          isShowFlag: true,
          isShowTitle: true,
          isShowCode: true,
          isDownIcon: true,
          showEnglishName: false,
          labelColor: Colors.blueAccent,
        ),
        initialSelection: '+62',
        // or
        // initialSelection: 'US'
        onChanged: (CountryCode code) {
          print(code.name);
          print(code.code);
          print(code.dialCode);
          print(code.flagUri);
        },
      ),
    );
  }

}
