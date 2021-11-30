import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter1/authHome/model/time_entry.dart';
import 'package:flutter1/helpers/device_input.dart';

class UserDrug {  //會員設定的藥品
  String key;
  String CSname;
  // String userDI;

  UserDrug(this.CSname); //this.userDI

  UserDrug.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        CSname = snapshot.value["drugText"];
  // userDI = snapshot.value["適應症"];

  toJson() {
    return {
      "CSname": CSname,
      // "userDI": userDI,
    };
  }
}
DatabaseReference mainReference = FirebaseDatabase.instance.reference();

class DrugAText{
  static String drugAText;

  Future<String> readDrugAText()  async{
    await mainReference
        .child("device").child(GetDeviceID.getDeviceID).child("drugA").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        drugAText = values['drugText'];
      });
      print("名稱：");
      print(drugAText);
      return drugAText;
    });
  }
}

class DrugBText{
  static String drugBText;

  Future<String> readDrugBText()  async{
    await mainReference
        .child("device").child(GetDeviceID.getDeviceID).child("drugA").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        drugBText = values['drugText'];
      });
      print("名稱：");
      print(drugBText);
      return drugBText;
    });
  }
}

class DrugCText{
  static String drugCText;

  Future<String> readDrugCText()  async{
    await mainReference
        .child("device").child(GetDeviceID.getDeviceID).child("drugA").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        drugCText = values['drugText'];
      });
      print("名稱：");
      print(drugCText);
      return drugCText;
    });
  }
}

class DrugDText{
  static String drugDText;

  Future<String> readDrugDText()  async{
    await mainReference
        .child("device").child(GetDeviceID.getDeviceID).child("drugA").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        drugDText = values['drugText'];
      });
      print("名稱：");
      print(drugDText);
      return drugDText;
    });
  }
}

class CheckDeviceID{
  // static Map devicesID;
  //
  //   getDevicesID() async {
  //    String devicesID;
  //    mainReference.child("devices").once().then((DataSnapshot snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, values) {
  //       devicesID = values['device_id'];
  //       setState(() {
  //         petrolPumpData = petrolPumpLocations;
  //       });
  //     });
  //     print("所有裝置ID：");
  //     print(devicesID);
  //     return devicesID;
  //   });
  // }
  //
  //  String getUserDeviceID() {
  //     String userDeviceID;
  //    mainReference.child("users").once().then((DataSnapshot snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, values) {
  //       userDeviceID = values['device_id'];
  //     });
  //     print("會員的裝置ID：");
  //     print(userDeviceID);
  //     return userDeviceID;
  //   });
  // }

  // void checkDeviceID() async {
  //
  //   devices.once().then((DataSnapshot snapshot) { //查詢devices裡所有的device_id
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, values) {
  //       userDeviceID = values["device_id"];
  //       var childKey = key;
  //       print(values["device_id"]);
  //       print(
  //           "childID名稱：");
  //       print(childKey);
  //     });
  //   });
  // }

}
//
// List<DrugItem> drugItemList;
// List<UserDrug> userDrugList;
//
// Future<List<DrugItem>> _getFollowersUsers() async {
//   DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
//   DataSnapshot snapshot = await databaseReference
//       .child('users').child(StaticInfo.userid)
//       .once();
//
//   List<DrugItem> drugItemList = [];
//   for (DataSnapshot item in snapshot.value) {
//     var data = item.value;
//     if (data["id"] == _userId) continue;
//
//     DrugItem drugItem = DrugItem();
//     user.name = data["name"];
//     user.photoUrl = data["imageUrl"];
//     user.username = data["username"];
//     user.id = data["id"];
//     user.bio = data["bio"];
//
//     drugItemList.add(user);
//   }
//
//   return drugItemList;
// }
//
// Future<List<Users>> _getFollowingUsers() async {
//   Firestore db = Firestore.instance;
//
//   QuerySnapshot querySnapshot = await db
//       .collection('following')
//       .document(_userId)
//       .collection("userFollowing")
//       .getDocuments();
//
//   List<Users> followingList = [];
//   for (DocumentSnapshot item in querySnapshot.documents) {
//     var data = item.data;
//     if (data["id"] == _userId) continue;
//
//     Users user = Users();
//     user.name = data["name"];
//     user.photoUrl = data["imageUrl"];
//     user.username = data["username"];
//     user.id = data["id"];
//     user.bio = data["bio"];
//
//     followingList.add(user);
//   }
//
//   return followingList;
// }
//
// getFinalList() {
//   List<User> result = [];
//   followingList.forEach((aElement) {
//     User value =
//     followersList.firstWhere((bElement) => bElement.id == aElement.id, orElse: () => null);
//     if (value != null) {
//       result.add(value);
//     }
//   });
//   print(result);
// }