import 'package:flutter/material.dart';
import 'package:mni/auth/sign_in.dart';
import 'package:mni/localization/language/languages.dart';
import 'package:mni/localization/locale_constant.dart';
import 'package:mni/model/language_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return  Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  title: Text('support email'),
                  actionsPadding: EdgeInsets.all(16.0),
                  actions: [
                    RaisedButton(
                      child: Text('Close'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                  content: Text('info@omnii.info'),
                );
              });
        },
        label: Text('support'),
        icon: Icon(Icons.sms),
      ),
        appBar: AppBar(
          leading: Icon(
            Icons.language,
            color: Colors.white,
          ),
          title: Text(Languages
              .of(context)
              .appName),
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                _createLanguageDropDown(),
                SizedBox(
                  height: 40,
                ),
                Center(
                    child:Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          _signInButton(_width)
                        ])),
              ],
            ),
          ),
        ),
      );}
  Widget _signInButton(_width) {
    return OutlineButton(

      onPressed: () {
        signInWithGoogle().then((result) async {
          if (result != null) {
            print(result);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('login', true);
            Navigator.of(context).pushNamed('/SetStateToHomeScreen');

          }
        });

      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child:   Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage("assets/google_icons.jpeg"),
                    width: 40, height: 40, fit: BoxFit.cover
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Text(
                    Languages
                        .of(context)
                        .labelGoogle,
                    style: TextStyle(
                      fontSize: _width/30,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            )),

    );
  }
  _createLanguageDropDown() {
    return DropdownButton<LanguageData>(
      iconSize: 30,
      hint: Text(Languages
          .of(context)
          .labelSelectLanguage),
      onChanged: (LanguageData language) {
        changeLanguage(context, language.languageCode);
      },

      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) =>
            DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
      )
          .toList(),
    );
  }
}

class SetStateToHomeScreen extends StatefulWidget {
  @override
  _SetStateToHomeScreenState createState() => _SetStateToHomeScreenState();
}
class _SetStateToHomeScreenState  extends State<SetStateToHomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(Languages
            .of(context)
            .appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            labelLangA(Languages
                .of(context)
                .labelLangA),
            labelLangB(Languages
                .of(context)
                .labelLangE),
          ],
        ),
      ),
    );
  }
  ElevatedButton labelLangA(labelL){

    return   ElevatedButton(
      onPressed: () {
        // When the user taps the button,
        // navigate to a named route and
        // provide the arguments as an optional
        // parameter.
        Navigator.of(context).pushNamed('/TabBarDemo');
      },
      child: Text(labelL),
    );
  }
  ElevatedButton labelLangB(labelL){

    return   ElevatedButton(
      onPressed: () {
        // When the user taps the button,
        // navigate to a named route and
        // provide the arguments as an optional
        // parameter.
        Navigator.of(context).pushNamed('/TabBar2');
      },
      child: Text(labelL),
    );
  }

}

