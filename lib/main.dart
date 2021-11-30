import 'package:flutter/material.dart';
import 'helpers/Constants.dart';
import 'LoginPage.dart';
import 'HomePage.dart';
import 'RegisterPage.dart';
import 'helpers/auth_helper.dart';
import 'package:flutter1/admin_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final routes = <String, WidgetBuilder>{
      loginPageTag: (context) => LoginPage(),
      homePageTag: (context) => HomePage(),
      RegisterPageTag: (context) => RegisterPage(),

    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,  //右上角debug取消
      title: '智慧藥盒',
      theme: new ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(241, 237, 225, 1.0),
      ),
      home: MainScreen(),
    );

  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(snapshot.data.uid).snapshots() ,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc.data();
                  if(user['role'] == 'user') {
                    return HomePage();
                  }else if(user['role'] == 'admin') {
                    return AdminHomePage();
                  }
                else{
                  return LoginPage();
                }
                }else{
                  return Material(
                    child: Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(204, 119, 34, 1.0),),
                    )
                    ),
                  );
                }
              },
            );
          }
          return LoginPage();
        }
    );
  }
}
