import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';  //
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter1/authHome/model/time_entry.dart';
import 'package:flutter1/authHome/model/time_firebase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

abstract class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  @override

  static changePassword(String newPassword) async {
    User user = await FirebaseAuth.instance.currentUser;
    user.updatePassword(newPassword).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  static signInWithEmail({ String email, String password}) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = res.user;
      await user.reload();

      return user;
    } catch (e) {
      print(e.toString());
      return null;

    }
  }

  static signupWithEmail({String name, String email, String password, String sex, String birth}) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = res.user;
      res.user.updateDisplayName(name);
      await user.reload();

      print("註冊的會員：");
      print(user);


      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final acc = await googleSignIn.signIn();
    final auth = await acc.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    final res = await _auth.signInWithCredential(credential);
    return res.user;
  }

  static logOut() async {
    GoogleSignIn().signOut();
    await _auth.signOut();
  }

}

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");  //realTIme


  static saveUser(User user) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    Map<String, dynamic> userData = {
      "name": user.displayName,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": "user",
      "build_number": buildNumber,
      "uid": user.uid,
    };
    StaticInfo.userid = user.uid;
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists)   {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "build_number": buildNumber,
        "name": user.displayName, ////
      });

      await usersRef.reference().child(user.uid).update({
        'username': user.displayName,
        'uid': user.uid,
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
      await usersRef.reference().child(user.uid).set({
        'username': user.displayName,
        'uid': user.uid,
        'device_id': "null",
      });
    }
    await _saveDevice(user);
  }

  static _saveDevice(User user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    Map<String, dynamic> deviceData;
    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = {
        "os_version": deviceInfo.version.sdkInt.toString(),
        "platform": 'android',
        "model": deviceInfo.model,
        "device": deviceInfo.device,
      };
    }
    if (Platform.isIOS) {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        "os_version": deviceInfo.systemVersion,
        "device": deviceInfo.name,
        "model": deviceInfo.utsname.machine,
        "platform": 'ios',
      };
    }
    final nowMS = DateTime
        .now()
        .toUtc()
        .millisecondsSinceEpoch;
    final deviceRef = _db
        .collection("users")
        .doc(user.uid)
        .collection("devices")
        .doc(deviceId);
    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        "updated_at": nowMS,
        "uninstalled": false,
      });
      await usersRef.reference().child(user.uid).update({
        'username': user.displayName,
        'uid': user.uid,
      });
    } else {
      await deviceRef.set({
        "updated_at": nowMS,
        "uninstalled": false,
        "id": deviceId,
        "created_at": nowMS,
        "device_info": deviceData,
      });
      await usersRef.reference().child(user.uid).set({
        'username': user.displayName,
        'uid': user.uid,
        'device_id': "null",
      });
    }
  }
}
abstract class BaseAuth {

  Future<void> changePassword(String password);

}