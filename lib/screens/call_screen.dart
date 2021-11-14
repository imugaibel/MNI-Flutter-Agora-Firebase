import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:mni/Widgets/user_view.dart';
import 'package:mni/auth/firestoreDB.dart';
import 'package:mni/model/live.dart';
import 'package:mni/utils/appId.dart';
import 'package:wakelock/wakelock.dart';

class CallScreen extends StatefulWidget {

  final String userName;
  final ClientRole role;
  final String image;

  CallScreen({ this.userName, this.role,this.image});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool completed = false;
  bool muted = false;
  bool _isLogin = false;
  bool _isInChannel = false;
  final _broadcaster = <String>[];
  final _audience = <String>[];
  final Map<int, String> _allUsers = {};
  List<Live> list =[];
  AgoraRtmClient _client;
  AgoraRtmChannel _channel;
  int userNo = 0;
  var len;
  final buttonStyle = TextStyle(color: Colors.white, fontSize: 15);

  int localUid;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk

    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    _channel.leave();
    _allUsers.clear();
    _broadcaster.clear();
    _audience.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
    _createClient();

  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    print('--------------------------------------');
    await _initAgoraRtcEngine();
    await _addAgoraEventHandlers();
    // await _engine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.joinChannel(null, widget.userName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {

    await AgoraRtcEngine.create(appId);
    await AgoraRtcEngine.disableVideo();
    await AgoraRtcEngine.enableAudio();
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(widget.role);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {

    AgoraRtcEngine.onJoinChannelSuccess = (
        String channel,
        int uid,
        int elapsed,
        ) async{



        var date = DateTime.now();
        var currentTime = '${DateFormat("dd-MM-yyyy hh:mm:ss").format(date)}';
        print('--------------------------------------');
        print(widget.image+''+widget.userName+''+uid.toString()+''+currentTime);
        FireStoreClass.createliveAudio(name:  widget.userName,id: uid,time: currentTime,image:widget.image);
             print(widget.image);
             print("uid: "+uid.toString());


      // The above line create a document in the firestore with username as documentID

      await Wakelock.enable();
      // This is used for Keeping the device awake. Its now enabled

      Wakelock.enable();
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      if(uid==_channel){
        setState(() {
          completed=true;
          Future.delayed(const Duration(milliseconds: 1500), () async{
            await Wakelock.disable();
            Navigator.pop(context);
          });
        });
      }
      _users.remove(uid);
    };


  }

  void _createClient() async {
    _client = await AgoraRtmClient.createInstance(appId);
    _client.onConnectionStateChanged = (int state, int reason) {
      if (state == 5) {
        _client.logout();
        print('Logout.');

      }
    };

    String userId = widget.userName;
    await _client.login(null, userId);
    print('Login success: ' + userId);
    setState(() {
      _isLogin = true;
    });
    String channelName = widget.userName;
    _channel = await _createChannel(channelName);

    await _channel.join();
    print('RTM Join channel success.');
    _channel.getMembers().then((value) => print(value));
    setState(() {
      _isInChannel = true;
    });
    await _channel.sendMessage(AgoraRtmMessage.fromText('$localUid:join'));
    _client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      print("Peer msg: " + peerId + ", msg: " + message.text);

      var userData = message.text.split(':');

      if (userData[1] == 'leave') {
        print('In here');
        setState(() {
          _allUsers.remove(int.parse(userData[0]));
        });
      } else {
        setState(() {
          _allUsers.putIfAbsent(int.parse(userData[0]), () => peerId);
        });
      }
    };
    _channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
      print(
          'Outside channel message received : ${message.text} from ${member.userId}');

      var userData = message.text.split(':');

      if (userData[1] == 'leave') {
        setState(() {
          _allUsers.remove(int.parse(userData[0]));
        });
      } else {
        print('Broadcasters list : $_users');
        print('All users lists: ${_allUsers.values}');
        setState(() {
          _allUsers.putIfAbsent(int.parse(userData[0]), () => member.userId);
        });
      }
    };

    for (var i = 0; i < _users.length; i++) {
      if (_allUsers.containsKey(_users[i])) {
        setState(() {
          _broadcaster.add(_allUsers[_users[i]]);
        });
      } else {
        setState(() {
          _audience.add('${_allUsers.values}');

        });
      }
    }
  }

  Future<AgoraRtmChannel> _createChannel(String name) async {
    AgoraRtmChannel channel = await _client.createChannel(name);
    channel.onMemberJoined = (AgoraRtmMember member) async {
      print('Member joined : ${member.userId}');
      // setState(() {

      // });
      await _client.sendMessageToPeer(
          member.userId, AgoraRtmMessage.fromText('$localUid:join'));
    };

    channel.onMemberLeft = (AgoraRtmMember member) async {
      var reversedMap = _allUsers.map((k, v) => MapEntry(v, k));
      print('Member left : ${member.userId}:leave');
      print('Member left : ${reversedMap[member.userId]}:leave');

      setState(() {
        _allUsers.remove(reversedMap[member.userId]);
      });
      await channel.sendMessage(
          AgoraRtmMessage.fromText('${reversedMap[member.userId]}:leave'));
    };

    channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
      print('Channel message received : ${message.text} from ${member.userId}');

      var userData = message.text.split(':');

      if (userData[1] == 'leave') {
        _allUsers.remove(int.parse(userData[0]));
      } else {
        _allUsers.putIfAbsent(int.parse(userData[0]), () => member.userId);
      }
    };
    return channel;
  }

  /// Toolbar layout
  Widget _toolbar() {
    return widget.role == ClientRole.Audience
        ? Container()
        : Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Row(
                    children: [
                      Icon(
                        muted ? Icons.mic_off : Icons.mic,
                        color: muted ? Colors.white : Colors.blueAccent,
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      muted
                          ? Text(
                              'Unmute',
                              style: buttonStyle,
                            )
                          : Text(
                              'Mute',
                              style: buttonStyle.copyWith(color: Colors.black),
                            )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2.0,
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(15.0),
                ),
                // FireStoreClass.deleteUser(username: channelName);
                RawMaterialButton(
                  onPressed: () async {
                    FireStoreClass.deleteAudiostram(username: widget.userName);
                   _onCallEnd(context);
                    await Wakelock.disable();
                    AgoraRtcEngine.leaveChannel();
                    AgoraRtcEngine.destroy();
                    Navigator.of(context).pushNamed('/TabBarDemo');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Disconnect',
                        style: buttonStyle,
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
              ],
            ),
          );
  }
  Widget _liveText(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(
              widget.image,fit: BoxFit.contain,   width: 50.0,
              height: 50.0,),
            Text(widget.userName ?? ''),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.indigo, Colors.blue
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4.0))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8.0),
                child: Text('LIVE',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:5,right:10),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6),
                      borderRadius: BorderRadius.all(Radius.circular(4.0))
                  ),
                  height: 28,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.eye,color: Colors.white,size: 13,),
                        SizedBox(width: 5,),
                        Text('${_allUsers.length}',style: TextStyle(color: Colors.white,fontSize: 11),),
                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: Column(
        children: [
          _liveText(),

        Center(child:  Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (BuildContext context, int index) {
                  print(_allUsers[_users[index]]);
                  return _allUsers.containsKey(_users[index])
                      ? UserView(
                          userName: _allUsers[_users[index]],
                          role: ClientRole.Audience,
                        )
                      : Container();
                },
              ))),
        //  print( _audience.length.toString());
        /*  Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: ListView.builder(
                itemCount: _allUsers.length - _users.length,
                itemBuilder: (BuildContext context, int index) {
                  return _users.contains(_allUsers.keys.toList()[index])
                      ? Container()
                      : UserView(
                          role: ClientRole.Audience,
                          userName: _allUsers.values.toList()[index],
                        );
                },
              )),*/
          _toolbar()
        ],
      )),
    );
  }
}
