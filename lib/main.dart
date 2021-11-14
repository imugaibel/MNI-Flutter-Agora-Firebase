import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mni/screens/TabBarDemo.dart';
import 'package:mni/screens/profile.dart';
import 'package:mni/screens/profile_screen.dart';
import 'package:mni/screens/home.dart';
import 'package:mni/screens/profile_screens/Application_Policy.dart';
import 'package:mni/screens/profile_screens/Coupons_screen.dart';
import 'package:mni/screens/profile_screens/Messages_screen.dart';
import 'package:mni/screens/profile_screens/Privacy_policy.dart';
import 'package:mni/screens/profile_screens/Settings_screen.dart';
import 'package:mni/screens/profile_screens/ask_help.dart';
import 'package:mni/screens/profile_screens/edit_profil.dart';
import 'package:mni/screens/profile_screens/search_screen.dart';
import 'package:mni/screens/profile_screens/wallet2_screen.dart';
import 'package:mni/screens/profile_screens/wallet_screen.dart';
import 'package:mni/screens/profile_screens/whoarewe_screen.dart';
import 'package:mni/screens/tabbar.dart';
import 'package:mni/splash/splash_loading_page.dart';
import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
}


class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/TabBarDemo': (BuildContext context) => TabBarDemo(),
        '/TabBar2': (BuildContext context) => TabBar2(),
        '/ProfileScreen': (BuildContext context) => ProfileScreen(),
        '/Profile': (BuildContext context) => Profile(),
        '/SetStateToHomeScreen': (BuildContext context) => SetStateToHomeScreen(),
        '/Home': (BuildContext context) => Home(),
        //profile
        '/ApplicationPolicy': (BuildContext context) => Application_Policy(),
        '/ask_help': (BuildContext context) => ask_help(),
        '/Messages_screen': (BuildContext context) => Messages_screen(),
        '/search_screen': (BuildContext context) => search_screen(),
        '/Settings_screen': (BuildContext context) => Settings_screen(),
        '/wallet_screen': (BuildContext context) => wallet_screen(),
        '/wallet2_screen': (BuildContext context) => wallet2_screen(),
        '/whoarewe_screen': (BuildContext context) => whoarewe_screen(),
        '/Privacy_policy': (BuildContext context) => Privacy_policy(),
        '/Coupons_screen': (BuildContext context) => Coupons_screen(),
        '/Edit_Profil': (BuildContext context) => Edit_Profil(),
      },
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },      debugShowCheckedModeBanner: false,
      locale: _locale,
      home: MySplashLoadingPage(),
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
        Locale('fr', ''),
        Locale('tr', ''),
        Locale('sv', ''),
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
