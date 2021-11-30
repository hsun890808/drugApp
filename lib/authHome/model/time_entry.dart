import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter1/helpers/device_input.dart';

// realtime
final DatabaseReference timeCollection = FirebaseDatabase.instance.reference();

class StaticInfo{
  static String userid;

  static Stream<Event> readUserDeviceID() {
    Query timeItemCollection =
    timeCollection.child("users").child(userid);
    return timeItemCollection.onValue;
  }

  static Stream<Event> readItemsA() {
    Query timeItemCollection =
    timeCollection.child("device").child(GetDeviceID.getDeviceID).child("drugA");
    return timeItemCollection.onValue;
  }
  static Stream<Event> readItemsB() {
    Query timeItemCollection =
    timeCollection.child("device").child(GetDeviceID.getDeviceID).child("drugB");
    return timeItemCollection.onValue;
  }
  static Stream<Event> readItemsC() {
    Query timeItemCollection =
    timeCollection.child("device").child(GetDeviceID.getDeviceID).child("drugC");
    return timeItemCollection.onValue;
  }
  static Stream<Event> readItemsD() {
    Query timeItemCollection =
    timeCollection.child("device").child(GetDeviceID.getDeviceID).child("drugD");
    return timeItemCollection.onValue;
  }
}

class DrugARealtime {
  String key;
  String id;
  DateTime fromDateTime;
  DateTime toDateTime;
  int active;
  String text;
  int notificationId;

  DrugARealtime(this.fromDateTime, this.toDateTime, this.active, this.text, this.notificationId);  //this.note

  DrugARealtime.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        fromDateTime =snapshot.value["fromDate"],
        toDateTime =snapshot.value["toDate"],
        active = snapshot.value["active"],
        text = snapshot.value["DrugText"];
  // notificationId = snapshot.value["notificationId"];
  //var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  // note = snapshot.value["note"];

  Map<String, dynamic> toJson() =>
      {
        "fromDate": fromDateTime,     //.millisecondsSinceEpoch
        "toDate": toDateTime,
        "active": active,
        "text": text,
        "notificationId": notificationId,
        // "note": note

      };

}

class DrugBRealtime {
  String key;
  String id;
  DateTime fromDateTime;
  DateTime toDateTime;
  int active;
  String text;
  int notificationId;

  DrugBRealtime(this.fromDateTime, this.toDateTime, this.active, this.text, this.notificationId);  //this.note

  DrugBRealtime.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        fromDateTime =snapshot.value["fromDate"],
        toDateTime =snapshot.value["toDate"],
        active = snapshot.value["active"],
        text = snapshot.value["DrugText"];
  // notificationId = snapshot.value["notificationId"];
  //var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  // note = snapshot.value["note"];

  Map<String, dynamic> toJson() =>
      {
        "fromDate": fromDateTime,     //.millisecondsSinceEpoch
        "toDate": toDateTime,
        "active": active,
        "text": text,
        "notificationId": notificationId,
        // "note": note

      };

}

class DrugCRealtime {
  String key;
  String id;
  DateTime fromDateTime;
  DateTime toDateTime;
  int active;
  String text;
  int notificationId;

  DrugCRealtime(this.fromDateTime, this.toDateTime, this.active, this.text, this.notificationId);  //this.note

  DrugCRealtime.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        fromDateTime =snapshot.value["fromDate"],
        toDateTime =snapshot.value["toDate"],
        active = snapshot.value["active"],
        text = snapshot.value["DrugText"];
  // notificationId = snapshot.value["notificationId"];
  //var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  // note = snapshot.value["note"];

  Map<String, dynamic> toJson() =>
      {
        "fromDate": fromDateTime,     //.millisecondsSinceEpoch
        "toDate": toDateTime,
        "active": active,
        "text": text,
        "notificationId": notificationId,
        // "note": note

      };

}

class DrugDRealtime {
  String key;
  String id;
  DateTime fromDateTime;
  DateTime toDateTime;
  int active;
  String text;
  int notificationId;

  DrugDRealtime(this.fromDateTime, this.toDateTime, this.active, this.text, this.notificationId);  //this.note

  DrugDRealtime.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        fromDateTime =snapshot.value["fromDate"],
        toDateTime =snapshot.value["toDate"],
        active = snapshot.value["active"],
        text = snapshot.value["DrugText"];
  // notificationId = snapshot.value["notificationId"];
  //var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  // note = snapshot.value["note"];

  Map<String, dynamic> toJson() =>
      {
        "fromDate": fromDateTime,     //.millisecondsSinceEpoch
        "toDate": toDateTime,
        "active": active,
        "text": text,
        "notificationId": notificationId,
        // "note": note

      };

}