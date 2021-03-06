
import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class FireStoreClass{
  static final Firestore _db = Firestore.instance;
  static final liveCollection = 'liveuser';
  static final liveAudio = 'Audiouser';
  static final userCollection = 'users';
  static final emailCollection = 'user_email';

  static void createLiveUser({name, id, time,image}) async{
    final snapShot = await _db.collection(liveCollection).document(name).get();
    print("*****************************************************2");
   // print('snapShot : ${snapShot.data.isEmpty}');
    if(snapShot.exists){
      await _db.collection(liveCollection).document(name).updateData({
        'name': name,
        'channel': id,
        'time':time,
        'image': image
      });
    } else {
      await _db.collection(liveCollection).document(name).setData({
        'name': name,
        'channel': id,
        'time':time,
        'image': image
      });
    }
  }
  static void createliveAudio({name, id, time,image}) async{
    final snapShot = await _db.collection(liveAudio).document(name).get();
    if(snapShot.exists){
      await _db.collection(liveAudio).document(name).updateData({
        'name': name,
        'channel': id,
        'time':time,
        'image': image
      });
    } else {
      await _db.collection(liveAudio).document(name).setData({
        'name': name,
        'channel': id,
        'time':time,
        'image': image
      });
    }
  }
  static Future<String> getImage ({username}) async{
    final snapShot = await _db.collection(userCollection).document(username).get();
    return snapShot.data['image'];
  }

  static Future<String> getName ({username}) async{
    final snapShot = await _db.collection(userCollection).document(username).get();
    return snapShot.data['name'];
  }


  static Future<bool> checkUsername({email}) async{
    final snapShot = await _db.collection(emailCollection).document(email).get();
    //print('Xperion ${snapShot.exists} $username');
    if(snapShot.exists) {
      return false;
    }
    return true;
  }

  static Future<void> regUser({name, email, username, image,phoneNumber}) async{

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('image', image);
    await prefs.setString('phoneNumber', phoneNumber==null?'':phoneNumber);

    await _db.collection(userCollection).document(username).setData({
      'name': name,
      'email': email,
      'username': username,
      'image': image,
      'phoneNumber':phoneNumber
    });
    await _db.collection(emailCollection).document(email).setData({
      'name': name,
      'email': email,
      'username': username,
      'image': image,
      'phoneNumber':phoneNumber
    });
    return true;
  }

  static void deleteUser({username}) async{
    await _db.collection('liveuser').document(username).delete();
  }

  static void deleteAudiostram({username}) async{
    await _db.collection("Audiouser").document(username).delete();
  }

  static Future<void> getDetails({email}) async{
    var document = await Firestore.instance.document('user_email/$email').get();
    var checkData = document.data;
    if(checkData==null)
      return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', document.data['name']);
    await prefs.setString('username', document.data['username']);
    await prefs.setString('image', document.data['image']);
  }

}