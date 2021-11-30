import 'package:cloud_firestore/cloud_firestore.dart';
import 'helpers/auth_helper.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

//管理者登入畫面
class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (BuildContext context,
                  snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final docs = snapshot.data.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = docs[index].data();
                      return ListTile(
                        title: Text(user['name'] ?? user['email']),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text("Log out"),
                    onPressed: () {
                      AuthHelper.logOut();
                    },
                  )
                ),
                Expanded(
                  child: RaisedButton(   //還是錯的!
                    child: Text("Back App"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomePage(),
                          ));
                    },
                  )
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
