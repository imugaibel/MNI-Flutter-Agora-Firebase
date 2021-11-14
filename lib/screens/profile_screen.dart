import 'package:flutter/material.dart';
import 'package:mni/auth/sign_in.dart';
import 'package:mni/localization/language/languages.dart';
class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {

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
                  .prfTitle),
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
            child: Center(
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
                              .labelPrf1),
                          rowCell(0, Languages
                              .of(context)
                              .labelPrf2),
                          rowCell(0, Languages
                              .of(context)
                              .labelPrf3),


                        ],),
                      new Divider(height: _height/30,color: Colors.blue),
                      Center(

                          child: Column(
                              children: <Widget>[

                                lisall(Languages.of(context).labelLis1,Icons.account_balance_wallet,'wallet2_screen'),
                                lisall(Languages.of(context).labelLis2,Icons.monetization_on,'Coupons_screen'),
                                lisall(Languages.of(context).labelLis3,Icons.present_to_all,''),
                                lisall(Languages.of(context).labelLis4,Icons.present_to_all,''),
                                lisall(Languages.of(context).labelLis5,Icons.read_more,'Privacy_policy'),
                                lisall(Languages.of(context).labelLis6,Icons.policy,'ApplicationPolicy'),
                                lisall(Languages.of(context).labelLis7,Icons.campaign,'ask_help'),
                                lisall(Languages.of(context).labelLis8,Icons.public,'whoarewe_screen'),
                              ]))
                    ])))));
  }
  Widget rowCell(int count, String type) => new Expanded(child: new Column(children: <Widget>[
    new Text('$count',style: new TextStyle(color: Colors.blue),),
    new Text(type,style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.normal))
  ],));
  ListTile lisall(title,icons,namescreeen){
    return    ListTile(
      leading: Icon(
        icons,
        color: Colors.blue,
      ),
      title: Text(title,style: new TextStyle(color: Colors.blue),),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        namescreeen==''?null: Navigator.of(context).pushNamed('/$namescreeen');
      },
    );
  }

}