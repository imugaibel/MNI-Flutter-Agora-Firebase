import 'dart:async';
import 'package:mni/auth/firestoreDB.dart';
import 'package:universal_html/html.dart' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mni/model/live.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'agora/host.dart';
import 'agora/join.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {

  final FlareControls flareControls = FlareControls();
  final databaseReference = Firestore.instance;
  List<Live> list =[];
  bool ready =false;
  Live liveUser;
  var name;
  var image ='https://nichemodels.co/wp-content/uploads/2019/03/user-dummy-pic.png';
  var username;
  var postUsername;
  int userNo = 0;

  @override
  Widget build(BuildContext context) {
    return getMain();
  }




  @override
  void initState() {
    super.initState();
    loadSharedPref();
    final list = [];
    liveUser = new Live(username: username,me: true,image:image );
    setState(() {
      list.add(liveUser);
    });
    dbChangeListen();
    /*var date = DateTime.now();
    var newDate = '${DateFormat("dd-MM-yyyy hh:mm:ss").format(date)}';
    */
  }


  Future<void> loadSharedPref() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Jon Doe';
      username = prefs.getString('username') ?? 'jon';
      image = prefs.getString('image') ?? 'https://nichemodels.co/wp-content/uploads/2019/03/user-dummy-pic.png';
    });
  }

  void dbChangeListen(){
    print("*****************************************************");
    databaseReference.collection('liveuser').orderBy("time",descending: true)
        .snapshots()
        .listen((result) {   // Listens to update in appointment collection
      print("*****************************************************");
    //  print(result.documents.first.data.isEmpty);
      setState(() {
        list = [];
        liveUser = new Live(username: username,me: true,image:image );
        list.add(liveUser);
      });
      result.documents.forEach((result) {
        setState(() {
          list.add(new Live(username: result.data['name'],image: result.data['image'],channelId:result.data['channel'],me: false));
          print("*****************************************************");
       //   print( result.data['name']);
        });
      });
    });
  }


  Widget getMain() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt),
        onPressed: () {
          print("*****************************************************1");
          for (Live users in list) {
            print('username: ${users.username}, image: ${ users.image} me: ${ users.me}  channelId: ${ users.channelId}');
            var date = DateTime.now();
            var currentTime = '${DateFormat("dd-MM-yyyy hh:mm:ss").format(date)}';
         //   FireStoreClass.createLiveUser(name: "documentId",id: users.channelId,time: currentTime,image:"widget.image");
            users.me?  onCreate(username: users.username, image: users.image):print("not me");
      //onCreate(username: users.username, image: users.image);

      print("*****************************************************2");
          }

        },
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget> [
                  Container(
                    height: 100,
                    child:  getchannellives(),
                  ),

                  SizedBox(height: 10,)
                ],
              )
            ],
          )
      ),
    );
  }


  Widget getchannellives() {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: getUserchannel()
    );
  }
  List<Widget> getUserchannel() {
    List<Widget> stories = [];
    for (Live users in list) {
      stories.add(getchannellive(users));
    }
    return stories;
  }


  Widget getchannellive(Live users) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          !users.me ?  Container(
              height: 70,
              width: 70,
              child: GestureDetector(
                onTap: (){
                  if(users.me!=true){
                    // Host function
                    print("Join function");
                    onJoin(channelName: users.username,channelId: users.channelId,username: username, hostImage: users.image,userImage: image);
                  }
                },
                child: Stack(
                  alignment: Alignment(0, 0),
                  children: <Widget>[
                    Image.network(
                      users.image,fit: BoxFit.cover,   width: 150.0,
                      height: 150.0,),
                    !users.me ?   Container(
                        height: 70,
                        width: 70,
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              height: 17,
                              width: 25,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        4.0) //         <--- border radius here
                                ),
                                gradient: LinearGradient(
                                    colors: [Colors.black, Colors.black],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight
                                ),
                              ),
                            ),
                            Container(
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          2.0) //         <--- border radius here
                                  ),
                                  gradient: LinearGradient(
                                      colors: [Colors.indigo, Colors.blueAccent],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight
                                  ),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'LIVE',
                                    style: TextStyle(
                                        fontSize: 7,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                            ),
                          ],
                        )
                    ):SizedBox(height: 3,),
                  ],
                ),
              )
          ): SizedBox(height: 3,),
          SizedBox(height: 3,),
          !users.me ?  Text(users.username ?? ''): SizedBox(height: 0,),
        ],
      ),
    );


  }
  Future<void> onJoin({channelName,channelId, username, hostImage, userImage}) async {
    // update input validation
    if (channelName.isNotEmpty) {
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinPage(
            channelName: channelName,
            channelId: channelId,
            username: username,
            hostImage: hostImage,
            userImage: userImage,
          ),
        ),
      );
    }
  }


  Future<void> onCreate({username, image}) async {
    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic();
    var date = DateTime.now();
    var currentTime = '${DateFormat("dd-MM-yyyy hh:mm:ss").format(date)}';
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: username,
          time: currentTime ,
          image: image,
        ),
      ),
    );

  }


  Future<void> _handleCameraAndMic() async {
    /// for android ios
   await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
    /// end android ios
    /// for web
    /*final perm = await html.window.navigator.permissions.query({"name": "camera"});
    if (perm.state == "denied") {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Oops! Camera access denied!"),
        backgroundColor: Colors.orangeAccent,
      ));
      return;
    }
    final stream = await html.window.navigator.getUserMedia(video: true);

    final perm1 = await html.window.navigator.permissions.query({"name": "microphone"});
    if (perm1.state == "denied") {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Oops! Camera access denied!"),
        backgroundColor: Colors.orangeAccent,
      ));
      return;
    }
    final stream1 = await html.window.navigator.getUserMedia(audio: true);*/
    /// end web
  }

}
