/*
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mni/auth/firestoreDB.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;
Future<String> signInWithGoogle() async {

  final googleSignInAccount = await googleSignIn.signIn();
  final googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final authResult = await _auth.signInWithCredential(credential);
  final user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  final UserCredential authResult =
  await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    //assert(user.photoURL != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    // Only taking the first part of the name, i.e., First Name
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }
  if(user!=null) {
    await FireStoreClass.regUser(name: user.displayName,email: user.email,username: user.displayName,image: user.photoUrl);
    var userNameExists = await FireStoreClass.checkUsername(email: user.email);
    if(!userNameExists) {
      await FireStoreClass.getDetails(email:user.email);
    }

  }
  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();
  print('User Sign Out');
}



Future<void> logout() async{
  var _auth = FirebaseAuth.instance;
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  _auth.signOut();
}
*/

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mni/auth/firestoreDB.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String imageUrl;
String phoneNumber;
Future<String> signInWithGoogle() async {

  final googleSignInAccount = await googleSignIn.signIn();
  final googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final authResult = await _auth.signInWithCredential(credential);
  final user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  if(user!=null) {
    await FireStoreClass.regUser(name: user.displayName,email: user.email,username: user.displayName,image: user.photoUrl,phoneNumber: user.phoneNumber==null?'':user.phoneNumber);
    var userNameExists = await FireStoreClass.checkUsername(email: user.email);
    if(!userNameExists) {
      await FireStoreClass.getDetails(email:user.email);
    }

  assert(user.email != null);
  assert(user.displayName != null);
  //assert(user.photoURL != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  phoneNumber = user.phoneNumber;

  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
  name = name.substring(0, name.indexOf(" "));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  assert(user.uid == currentUser.uid);

  print('signInWithGoogle succeeded: ${user.phoneNumber}');
  print('signInWithGoogle succeeded: ${user.providerId}');

  }
  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();
  print('User Sign Out');
}


Future<void> logout() async{
  var _auth = FirebaseAuth.instance;
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  _auth.signOut();
}

