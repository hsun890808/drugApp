//登入後Home顯示的介面
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/authHome/model/time_entry.dart';
import 'package:flutter1/helpers/device_input.dart';
//import 'authHome/set_time2.dart';
import 'helpers/auth_helper.dart';
import 'authHome/home.dart';
import 'authHome/set_time.dart';
import 'authHome/profile.dart';
import 'authHome/record.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  var _pageController = new PageController(initialPage: 1);
  String _title;
  String d;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  @override
  initState(){
    _title = '智慧藥盒';
    getd();
    print(" GetDeviceID().getd()");
    print(d);
  }


  var pages = <Widget>[
    SetTime(),
    Home(),
    Record(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Color.fromRGBO(210, 180, 140, 1.0),
        iconTheme: IconThemeData(color: Colors.grey), //change your color here
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.black),
          onPressed: () {
            AuthHelper.logOut();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ));
              Profile();
            },
            icon: Icon(Icons.person, color: Colors.black),
          ),
        ],
        title: Text(_title, style: TextStyle(fontSize: 25, color: Colors.white)),
        centerTitle: true,
      ),

      // body: pages[_currentIndex], // new
      body: new PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return pages.elementAt(_currentIndex);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Color.fromRGBO(204, 119, 34, 1.0),
        onTap: _onItemTapped, //click event
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.access_alarms_rounded),
            title: Text('吃藥時間'),
          ),

          new BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 36,),
            title: Text('吃藥時間',
              style: TextStyle(
                fontSize: 13.0,
              ),),

          ),

          new BottomNavigationBarItem(
            icon: Icon(Icons.source_outlined),
            title: Text('吃藥紀錄'),
          ),

          // new BottomNavigationBarItem(
          //     icon: Icon(Icons.person),
          //     title: Text('會員資料'),
          // )
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    //bottomNavigationBar and PageView association
    _pageController.animateToPage(index,duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
      switch(index) {
        case 0: { _title = '吃藥時間'; }
        break;
        case 1: { _title = '吃藥時間倒數'; }
        break;
        case 2: { _title = '吃藥紀錄'; }
        break;
      }
    });
  }

  Future<String> getd() async {
    DataSnapshot snapshot = await databaseReference
        .child('users').child(StaticInfo.userid)
        .once();
    d = snapshot.value['device_id'];
    return d;
  }
}