
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mni/model/live.dart';
import 'package:mni/screens/call_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Audio_screen extends StatefulWidget {
  @override
  _Audio_screenState createState() => _Audio_screenState();
}

class _Audio_screenState extends State<Audio_screen> {
  List<Live> list =[];
  var name;
  final databaseReference = Firestore.instance;
  var image ='https://nichemodels.co/wp-content/uploads/2019/03/user-dummy-pic.png';
  var username;
  List<bool> isSelected;
  int selectedPage = 0;
  ClientRole _role = ClientRole.Audience;
  Live liveAudio;
  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
    setState(() {
    loadSharedPref();});
    dbChangeListen();
    //final list = [];
  }
  Future<void> loadSharedPref() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Jon Doe';
      username = prefs.getString('username') ?? 'jon';
      image = prefs.getString('image') ?? 'https://nichemodels.co/wp-content/uploads/2019/03/user-dummy-pic.png';
      print("username : "+username);
      print("name : "+name);
      print("image : "+image);
      liveAudio = new Live(username: username,me: true,image:image , );
      setState(() {
        list.add(liveAudio);
        print("kyn"+list.length.toString());
        print("username :"+username.toString());
      });
    });
  }
  void dbChangeListen(){
    databaseReference.collection('Audiouser').orderBy("time",descending: true)
        .snapshots()
        .listen((result) {   // Listens to update in appointment collection
      setState(() {
        list = [];
        liveAudio = new Live(username: username,me: true,image:image );
        list.add(liveAudio);
      });
      result.documents.forEach((result) {
        setState(() {
          list.add(new Live(username: result.data['name'],image: result.data['image'],channelId:result.data['channel'],me: false));
        });
      });
    });

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
    return !users.me?Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
           Container(
              height: 70,
              width: 70,
              child: GestureDetector(
                onTap: () async {
                  if(users.me!=true){
                    // Host function
                    print("Join function");
                   // onJoin(channelName: users.username,channelId: users.channelId,username: username, hostImage: users.image,userImage: image);
                    for (Live users in list) {
                      print(users.channelId);
                      await _handleMicPermission();
                      !users.me?  Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CallScreen(
                                userName: users.username,
                                role: ClientRole.Audience,
                                image: users.image,
                              )
                          )
                      ):null;
                    } }
                },
                child: Stack(
                  alignment: Alignment(0, 0),
                  children: <Widget>[
                    Image.network(
                      users.image,fit: BoxFit.cover,   width: 150.0,
                      height: 150.0,),
              Container(
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
                                      colors: [Colors.green, Colors.greenAccent],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight
                                  ),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.mic_rounded,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                )
                            ),
                          ],
                        )
              )  ],
                ),
              )
          ),
          SizedBox(height: 3,),
          !users.me? Text(users.username ?? ''):  SizedBox(height: 3,),
        ],
      ),
    ): SizedBox(height: 3,);


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.mic),
        onPressed: () async {
       print(list.first.image);
       print(list.first.channelId);
       print(list.first.username);
       print(list.first.username);
       print(list.first.me.toString());
          for (Live users in list) {
          print(users.channelId);
           await _handleMicPermission();
           users.me?  Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => CallScreen(
                      userName: users.username,
                      role: ClientRole.Broadcaster,
                      image: users.image,
                    )
                )
            ):null;
          }}
          ),
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child:  getchannellives(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
               /*   ToggleButtons(
                    borderRadius: BorderRadius.circular(15),
                    borderWidth: 2,
                    borderColor: Colors.black,
                    selectedBorderColor: Colors.black,
                    selectedColor: Colors.white,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.87 / 2,
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text('Audience',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.87 / 2,
                        padding: EdgeInsets.all(8),
                        child: Center(child: Text('Broadcaster')),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                        selectedPage = index;
                      });
                      if (selectedPage == 0) {
                        setState(() {
                          _role = ClientRole.Audience;
                        });
                      } else {
                        setState(() {
                          _role = ClientRole.Broadcaster;
                        });
                      }
                      print(selectedPage);
                    },
                    fillColor: Colors.grey,
                    isSelected: isSelected,
                  ),*/
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
               /*   Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.16,
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () async {

                      },
                      child: Text(
                        'Join',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _handleMicPermission() async {
    Map<PermissionGroup, PermissionStatus> result = await PermissionHandler().requestPermissions(
        [PermissionGroup.microphone]
    );
    print(result);
  }
}
