import 'package:flutter/material.dart';

abstract class Languages {

  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get labelWelcome;

  String get labelInfo;

  String get labelSelectLanguage;

  String get labelGoogle;

  String get labelLangA;

  String get labelLangE;

  String get appTitle;
  String get appTitlePr1;
  String get  appTitlePr2;
  String get prfTitle;

  String get usrName;

  String get labelPrf1;

  String get labelPrf2;

  String get labelPrf3;

  String get labelPrf2_1;

  String get labelPrf2_2;

  String get labelPrf2_3;
  String get labelLis1;
  String get labelLis2;
  String get labelLis3;
  String get labelLis4;
  String get labelLis5;
  String get labelLis6;
  String get labelLis7;
  String get labelLis8;
  String get labelLis2_2;
  String get labelLis2_3;
  String get labelLis2_4;
  String get labelLis2_5;
  String get labelLis2_7;
  //app title
  String get AppPolyTitle;
  String get HelpTitle;
  String get CouponsTitle;
  String get MsgTitle;
  String get privTitle;
  String get searchTitle;
  String get SettingsTitle;
  String get walletTitle;
  String get wallet2Title;
  String get whoareTitle;


}
