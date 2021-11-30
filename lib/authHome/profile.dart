//當按下Home按鈕時，出現的介面
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/RegisterPage.dart';
import 'package:flutter1/authHome/model/database_compare.dart';
import 'package:flutter1/authHome/model/time_entry.dart';
import 'package:flutter1/helpers/device_input.dart';
import '../helpers/auth_helper.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.auth}) : super(key: key);
  final AuthHelper auth;

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _oldPWController = new TextEditingController();
  TextEditingController _newPWController = new TextEditingController();
  TextEditingController _confirmPWController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid = true;
  User _user;

  DatabaseReference users;
  DatabaseReference devices;

  String _confirmsword = "";
  List<DeviceID> deviceIDList = List();
  String _userDeviceID;


  //
  //  getUserDeviceID() async {
  //   mainReference.child("users").once().then((DataSnapshot snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, values) {
  //       Map userDeviceID = values['device_id'];
  //       setState(() {
  //         _userDeviceID = userDeviceID;
  //       });
  //     });
  //     print("會員的裝置ID：");
  //     print(_userDeviceID);
  //     return _userDeviceID;
  //   });
  // }


  @override
  void initState() {
    super.initState();
    initUser();
    users = FirebaseDatabase.instance.reference().child("users");
    devices = FirebaseDatabase.instance.reference().child("devices");
    devices.onChildAdded.listen(_onEntryAdded);
    // getUserDeviceID();
  }

  _onEntryAdded(Event event) {
    if (!mounted) return; ////
    setState(() {
      deviceIDList.add(DeviceID.fromSnapshot(event.snapshot));
    });
  }

  initUser() async {
    _user = await FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  _ProfileState() {
    _confirmPWController.addListener(_passwordListen);
  }

  void _passwordListen() {
    if (_confirmPWController.text.isEmpty) {
      _confirmsword = "";
    } else {
      _confirmsword = _confirmPWController.text;
    }
  }

  // void readData() {
  //   devices.once().then((DataSnapshot dataSnapshot) {
  //     print("status: " + dataSnapshot.value.toString());
  //     var status = dataSnapshot.value;
  //     setState(() {
  //       checkID = (status['status'].toString());
  //       print("readData：");
  //       print(checkID);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final newPW = TextFormField(
      cursorColor: Colors.black,
      autofocus: false,
      obscureText: true,
      controller: _newPWController,
      decoration: InputDecoration(
          labelText: "請輸入新密碼",
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black,
          )),
      validator: (String value) {
        if (value.isEmpty) {
          return '請輸入新密碼！';
        }
        if (value.length < 6) {
          return "密碼需大於6位數";
        }

        return null;
      },
    );

    final confirmPW = TextFormField(
      cursorColor: Colors.black,
      autofocus: false,
      obscureText: true,
      controller: _confirmPWController,
      decoration: InputDecoration(
          labelText: "確認新密碼",
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),

          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black,
          )
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return '請再次輸入新密碼！';
        }
        print(_newPWController.text);

        print(_confirmPWController.text);

        if (_newPWController.text != _confirmPWController.text) {
          return "兩次密碼不相同";
        }

        return null;
      },
    );


    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(210, 180, 140, 1.0),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 3.0),
                Container(
                  height: 35.0,
                  width: 400.0,
                  color: Color.fromRGBO(210, 180, 140, 1.0),
                  child: Text(
                    '會員帳號',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      letterSpacing: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    SizedBox(
                      child: Text(
                        '信箱：',
                        style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        _user?.email ?? '',
                        style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                new Form(
                  key: _formKey,
                  autovalidate: false, //是否自動校驗輸入內容
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                '姓名：',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                _user?.displayName ?? '',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.0),

                        Container(
                          height: 30,
                          child: StreamBuilder(
                            stream: StaticInfo.readUserDeviceID(),
                            builder: (context, AsyncSnapshot<Event> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              } else if (snapshot.hasData || snapshot.data != null) {
                                Map value = snapshot.data.snapshot.value;
                                _userDeviceID = value['device_id'];
                                return Ink(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      new Text(
                                        '裝置ID：',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          letterSpacing: 1,
                                        ),
                                      ),

                                      new Text(
                                        deviceIDNull(_userDeviceID),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                    ],
                                  ),
                                );
                              }

                              return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(204, 119, 34, 1.0),
                                    ),
                                  ));
                            },
                          ),
                        ),

                        SizedBox(height: 20.0),
                        Container(
                          height: 35.0,
                          width: 400.0,
                          color: Color.fromRGBO(210, 180, 140, 1.0),
                          child: Text(
                            '修改密碼',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              letterSpacing: 20,
                            ),
                          ),
                        ),
                        //
                        SizedBox(height: 10.0),
                        newPW,
                        SizedBox(height: 10.0),
                        confirmPW,
                        SizedBox(height: 18.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 250),
                          child: RaisedButton(
                            child: Text(
                              "修改",
                              style: TextStyle(fontSize: 20),
                            ),
                            color: Colors.black26,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                try {
                                  print("NewPassword=========>" + _confirmsword);
                                  AuthHelper.changePassword(_confirmsword);
                                  AuthHelper.changePassword(_confirmsword);
                                  print("更改成功");
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }

  saveDeviceID() async{
    users.reference().child(StaticInfo.userid).update({
      "device_id": GetDeviceID.getDeviceID,
    });
  }

  // void changeStatus() async{
  //   dynamic allDevice;
  //   devices.once().then((DataSnapshot snapshot){
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
  //   DataSnapshot userSnap = await users.reference().child(StaticInfo.userid).once();
  //   dynamic userDevice = userSnap.value['device_id'];
  //   print("userDevice：");
  //   print(userDevice);
  //
  //   if (allDevice == userDevice){
  //     devices.reference().child('/AP7Kk').update({
  //       "status": "T",
  //     });
  //     print("狀態已更改");
  //   }
  // }

  String deviceIDNull(String getDeviceID) {
    if(getDeviceID == "null" || getDeviceID == ""){
      return "新增裝置ID";
    }else{
      return GetDeviceID.getDeviceID;
    }
  }

//
// void checkDeviceID() async {
//
//   await users.reference().child(StaticInfo.userid).once().then((DataSnapshot data) {
//     if (data.value['device_id'] == null) {
//       print('no data');
//       return;
//     }
//     String result = data.value['device_id'];
//     print('This works');
//     print(result);
//   });
//
// }
}
