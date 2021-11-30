import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter1/authHome/model/time_entry.dart';
import 'package:flutter1/authHome/set_time.dart';
import 'package:fluttertoast/fluttertoast.dart';



// Future<bool> _deviceIDDB (String code) async {
// /// return true if no room with given code has been found in db
// return await deviceIDDB.child('deviceID')
// .once()
//     .then((snapshot) => snapshot.value == null);
// }
DatabaseReference users;
DatabaseReference devices;

@override
void initState() {
  users = FirebaseDatabase.instance.reference().child("users");
  devices = FirebaseDatabase.instance.reference().child("devices");
}
String inputData = '';
List<DeviceID> DeviceIDList = List();
DeviceID item = DeviceID("","");

Future<String> inputDeviceID(BuildContext context) async {


  return showDialog<String>(
    context: context,
    barrierDismissible: false, //控制點擊對話框以外的區域是否隱藏對話框
    builder: (BuildContext context) {
      return AlertDialog(

        title: Text('裝置ID',
      style: TextStyle(
      fontSize: 23.0,
      ),
        ),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
                  cursorColor: Colors.black,
                  autofocus: true,
                  decoration: new InputDecoration(
                      hintText: '請輸入裝置ID...' ,
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    inputData = value;
                  },
                ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop("null");
              }),
          FlatButton(
            child: Text('送出'),
            onPressed: ()  async {
              await checkDeviceID(inputData, context);
            },
          ),
        ],
      );

    },
  );
}

//
// void checkDeviceID() async{
//   dynamic allDevice;
//   devices.once().then((DataSnapshot snapshot){         //查詢devices裡所有的device_id
//     Map<dynamic, dynamic> values = snapshot.value;
//     values.forEach((key,values) {
//       allDevice = values["device_id"];
//       var childKey = key;
//       print(values["device_id"]);
//       print("childID名稱：");
//       print(childKey);
//     });
//   });

Future<void> checkDeviceID(String inputData, BuildContext context) async{
  DatabaseReference devices = FirebaseDatabase.instance.reference().child("devices");

  await devices.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, values) {
      String gDeviceID = values["device_id"];
      String gStatic = values["static"];
      print("key");
      print(key);
      print("gDeviceID:");
      print(values['device_id']);
      if (gDeviceID != inputData || gStatic == "T"){

        devices.reference().child(key).update({
          'static': "F",
        });
        Fluttertoast.showToast(msg: '無法使用此裝置ID',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 22.0);
        print("新增裝置ID錯誤");
        return;
      }
      if(gDeviceID == inputData && gStatic == "F"){

        devices.reference().child(key).update({
          'static': "T",
        });
        print("新增裝置ID成功");
        Navigator.of(context).pop(inputData);
      }
      print("輸入的裝置ID：");
      print(inputData);
    });
  });
}

class DeviceID {
  String key;
  String device_id;
  String _static;

  DeviceID(this.device_id, this._static);

  DeviceID.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        device_id = snapshot.value["device_id"],
        _static = snapshot.value["static"];
  toJson() {
    return {
      "CSname": device_id,
    };
  }
}


class GetDeviceID{
  DatabaseReference mainReference = FirebaseDatabase.instance.reference();
  static String getDeviceID = "null";
  String getID;

  Future<String> getd() async {
    await mainReference
        .child('users').child(StaticInfo.userid)
        .once().then((DataSnapshot snapshot) {
      getDeviceID = snapshot.value['device_id'];
      print("getDeviceID");
      print(getDeviceID);
      return getDeviceID;
    });
  }

}

//
// void checkDeviceID() async{
//   dynamic allDevice;
//   devices.once().then((DataSnapshot snapshot){         //查詢devices裡所有的device_id
//     Map<dynamic, dynamic> values = snapshot.value;
//     values.forEach((key,values) {
//       allDevice = values["device_id"];
//       var childKey = key;
//       print(values["device_id"]);
//       print("childID名稱：");
//       print(childKey);
//     });
//   });
//
//   DataSnapshot userSnap = await users.reference().child(StaticInfo.userid).once();   //查詢users裡的device_id
//   dynamic userDevice = userSnap.value['device_id'];
//   print("userDevice：");
//   print(userDevice);
//
//   if (allDevice == userDevice){import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter1/authHome/model/time_entry.dart';
// import 'package:flutter1/authHome/set_time.dart';
//
//
//
// // Future<bool> _deviceIDDB (String code) async {
// // /// return true if no room with given code has been found in db
// // return await deviceIDDB.child('deviceID')
// // .once()
// //     .then((snapshot) => snapshot.value == null);
// // }

// // void checkDeviceID() async{
// //   dynamic allDevice;
// //   devices.once().then((DataSnapshot snapshot){         //查詢devices裡所有的device_id
// //     Map<dynamic, dynamic> values = snapshot.value;
// //     values.forEach((key,values) {
// //       allDevice = values["device_id"];
// //       var childKey = key;
// //       print(values["device_id"]);
// //       print("childID名稱：");
// //       print(childKey);
// //     });
// //   });
// //
// //   DataSnapshot userSnap = await users.reference().child(StaticInfo.userid).once();   //查詢users裡的device_id
// //   dynamic userDevice = userSnap.value['device_id'];
// //   print("userDevice：");
// //   print(userDevice);
// //
// //   if (allDevice == userDevice){
// //     devices.reference().child("AP7Kk").update({
// //       "status": "T",
// //     });
// //     print("狀態已更改");
// //   }
// // }
//     devices.reference().child("AP7Kk").update({
//       "status": "T",
//     });
//     print("狀態已更改");
//   }
// }


