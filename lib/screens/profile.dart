import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';
import 'package:mni/auth/sign_in.dart';
import 'package:mni/localization/language/languages.dart';
import 'package:mni/screens/countrylist.dart';
import 'package:mni/spinning/spinningwheel.dart';
class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => new _ProfileState();
}
class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl = 'https://picsum.photos/id/237/200/300';

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  Scaffold(
            appBar: new AppBar(
              leading:  IconButton(
                icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(Languages
                  .of(context)
                  .prfTitle,),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    signOutGoogle();
                    Navigator.of(context).pushNamed('/Home');
                  },
                )
              ],
              backgroundColor: Colors.blue  ,
            ),
            body: new  SingleChildScrollView(
            child:Center(
                child: new Column(
                    children: <Widget>[
                      new  Padding( padding: new EdgeInsets.all(10.0),child:CircleAvatar(radius:_width<_height? _width/10:_height/10,backgroundImage: NetworkImage(imageUrl==null?imgUrl:imageUrl),)),
                      new SizedBox(height: _height/25.0,),
                      new Text(Languages
                          .of(context)
                            .usrName, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue),),
                      new Divider(height: _height/30,color: Colors.blue,),
                      new Row(
                        children: <Widget>[
                          rowCell(0, Languages
                              .of(context)
                                  .labelPrf2_1),
                          rowCell(0, Languages
                              .of(context)
                              .labelPrf2_2),
                          rowCell(0, Languages
                              .of(context)
                              .labelPrf2_3),


                        ],),
                      new Divider(height: _height/30,color: Colors.blue),
                      Center(

                        child: Column(
                          children: <Widget>[
                            rowlist(Languages.of(context).labelLis1,Languages.of(context).labelLis2_2,Icons.account_balance_wallet,Icons.mode_edit_outline,'wallet_screen','Edit_Profil'),
                            rowlist(Languages.of(context).labelLis2_3,Languages.of(context).labelLis2_4,Icons.construction,Icons.local_post_office,'Settings_screen','Messages_screen'),
                            rowlist(Languages.of(context).labelLis6,Languages.of(context).labelLis2_5,Icons.policy,Icons.travel_explore,'ApplicationPolicy','search_screen'),
                            rowlist(Languages.of(context).labelLis8,Languages.of(context).labelLis2_7,Icons.public,Icons.campaign,'whoarewe_screen','ask_help'),

                          ],
                        ),
                      ),


                      new SizedBox(height: _height/25.0,),
                      Center(child: SpinningWheelPage())

                    ])))));
  }
  Widget rowCell(int count, String type) => new Expanded(child: new Column(children: <Widget>[
    new Text('$count',style: new TextStyle(color: Colors.blue),),
    new Text(type,style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.normal))
  ],));
  ListTile lisall(Tiltle,icons,namescreeen){
    return    ListTile(
      leading: Icon(
       icons,
        color: Colors.blue,
      ),
      title: Text(Tiltle,style: new TextStyle(color: Colors.blue),),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {

        namescreeen==''?null: Navigator.of(context).pushNamed('/$namescreeen');
      },
    );
  }
  Row rowlist(Tiltle1,Title2,icons1,icons2,namescreeen1,namescreeen2){
    return Row(
      children: <Widget>[
        Flexible(
            child: lisall(Tiltle1,icons1,namescreeen1)
        ),
        Expanded(
            child: lisall(Title2,icons2,namescreeen2)
        ),
      ],
    );
  }
}