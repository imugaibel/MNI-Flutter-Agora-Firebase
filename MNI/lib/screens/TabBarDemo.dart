import 'package:flutter/material.dart';
import 'package:mni/auth/sign_in.dart';
import 'package:mni/localization/language/languages.dart';
import 'package:mni/screens/Live_screen.dart';
import 'package:mni/screens/audio_screen.dart';
class TabBarDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading:  IconButton(
              icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                //ProfileScreen
                // ignore: deprecated_member_use
                child:  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Profile');
                    },
                    child: Icon(
                      Icons.person_rounded,
                    )), ),],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.explore_outlined)),
                Tab(icon: Icon(Icons.live_tv_sharp)),
                Tab(icon: Icon(Icons.keyboard_voice_sharp)),
              ],
            ),
            title: Text(name),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              LivePage(),
              Audio_screen(),
            /*  MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Container(),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.mic),
                    onPressed: () {},    ),  ),),*/

    ],
          ),
        ),
      ),
    );
  }
}
