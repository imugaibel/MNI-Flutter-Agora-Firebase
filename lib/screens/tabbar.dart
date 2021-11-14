import 'package:flutter/material.dart';
import 'package:mni/auth/sign_in.dart';
import 'package:mni/localization/language/languages.dart';
class TabBar2 extends StatelessWidget {

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
                      Navigator.of(context).pushNamed('/ProfileScreen');
                    },
                    child: Icon(
                      Icons.person_rounded,
                    )), ),],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.coffee_outlined)),
                Tab(icon: Icon(Icons.fastfood_outlined)),
                Tab(icon: Icon(Icons.shopping_cart_outlined)),
              ],
            ),
            title: Text(name),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
