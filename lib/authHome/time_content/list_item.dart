// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter1/authHome/time_content/screens/edit_time.dart';
// import '../model/time_firebase.dart';
// import 'package:intl/intl.dart';
//
// //每個ListItem的設計
// class TimeListItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Entry.readItems(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong'); //若連不上firestore會顯示
//         } else if (snapshot.hasData || snapshot.data != null) {
//           return ListView.separated(
//             separatorBuilder: (context, index) => SizedBox(height: 16.0),
//             itemCount: snapshot.data.docs.length,
//             itemBuilder: (context, index) {
//               var noteInfo = snapshot.data.docs[index].data();
//               String docID = snapshot.data.docs[index].id;
//               String drugname = noteInfo['drugName'];
//               DateTime time =  noteInfo['fromDate'].toDate();
//               // String dateString = DateFormat('yyyy - MM - dd hh:mm').format(time);
//
//               return Ink(
//                 decoration: BoxDecoration(
//                   //list的眶
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: SizedBox(
//                   height: 100,
//                   child: ListTile(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     onTap: () => Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => EditScreen(
//                           currentTitle: DateFormat('yyyy年 MM月 dd日').add_jm().format(time), // DateFormat('yyyy年 MM月 dd日 hh:mm').format(time),//
//                           documentId: docID,
//                         ),
//                       ),
//                     ),
//                     title: Text(
//                       drugname ?? "",
//                       style: TextStyle(
//                         fontSize: 24,
//                       ),
//                     ),
//                     subtitle: Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Text(
//                        DateFormat('yyyy年 MM月 dd日').add_jm().format(time),
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                         // overflow: TextOverflow.ellipsis,
//                         // textAlign: TextAlign.right,
//                       ),
//                     ),
//                     // trailing: Switch(
//                     //     // value: snapshot.data.docs[index].active == 1,
//                     //     onChanged: (changingStatus) {
//                     //       // Toogle the status of the alarm clock first
//                     //       // if (snapshot.data.docs[index].active == 1)
//                     //       //   snapshot.data.docs[index].active = 0;
//                     //       // else
//                     //       //   snapshot.data.docs[index].active = 1;
//                     //
//                     //       // // Save the new status in the database
//                     //       // this._alarmDatabase.updateAlarm(allAlarmClocks[index]);
//                     //     }),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//
//         return Center(
//             child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(204, 119, 34, 1.0),),
//         )
//         );
//       },
//     );
//   }
// }
