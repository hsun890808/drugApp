// import 'dart:math';
// import 'package:intl/intl.dart';
// import 'package:flutter1/authHome/model/time_firebase.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter1/authHome/time_content/screens/search.dart';
// import 'package:flutter1/authHome/time_content/screens/med_mode.dart';
// import 'screens/add_time.dart';
//
// class AddForm extends StatefulWidget {
//   final Times timeToAdd;
//   final String text;
//
//   const AddForm({Key key, this.timeToAdd, this.text}) : super(key: key);
//
//   @override
//   _AddFormState createState() {
//     if (timeToAdd != null) {
//       return new _AddFormState(timeToAdd.fromDateTime, timeToAdd.toDateTime, timeToAdd.active, timeToAdd.text); //weighEntryToEdit.note
//     } else {
//       return new _AddFormState(new DateTime.now(), new DateTime.now(), 1, text);
//     }
//   }
// }
//
// class _AddFormState extends State<AddForm> {
//   // final _addItemFormKey = GlobalKey<FormState>();
//
//   // DateTime fromDate;
//   // DateTime toDate;
//   int active=1;
//   String text;
//   DateTime _fromDateTime = new DateTime.now();
//   DateTime _toDateTime = new DateTime.now();
//   TimeOfDay time = new TimeOfDay.now();
//
//   _AddFormState(this._fromDateTime, this._toDateTime, this.active, this.text);
//
//
//   Widget _createAppBar(BuildContext context) {
//     return new AppBar(
//       backgroundColor: Color.fromRGBO(210, 180, 140, 1.0),
//       actions: [
//         new FlatButton(
//           onPressed: () async {
//             int notificationId = Random().nextInt(1000);
//             await Entry.addItem(
//               fromDateTime: _fromDateTime,
//               toDateTime: _toDateTime,
//               drugText: text,
//               active:active,
//               notificationId: notificationId,
//             );
//             Navigator.of(context).pop();
//             // Navigator.of(context).pop(new Times(dateTime: _dateTime)); //_note
//           },
//           child: new Text('新增',
//               style: Theme.of(context)
//                   .textTheme
//                   .subhead
//                   .copyWith(color: Colors.white, fontSize: 20.0)),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: _createAppBar(context),
//       body: new Padding(
//         padding: const EdgeInsets.all(15),
//         child: ListView(
//           children: ListTile.divideTiles(context: context, tiles: [
//             new ListTile(
//               horizontalTitleGap: 10,
//               minLeadingWidth: 0,
//               onTap: (() => _showFromDatePicker(context)),
//               leading: new Icon(Icons.today, size: 22),
//               title: Text("開始日期", style: TextStyle(fontSize: 18)),
//               trailing: Text(
//                 new DateFormat('yyyy年 MM月 dd日').format(_fromDateTime),//設定畫面的年月日
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//
//             new ListTile(
//               horizontalTitleGap: 10,
//               minLeadingWidth: 0,
//               onTap: (() => _showToDatePicker(context)),
//               leading: new Icon(Icons.today, size: 22),
//               title: Text("結束日期", style: TextStyle(fontSize: 18)),
//               trailing: Text(
//                 new DateFormat('yyyy年 MM月 dd日').format(_toDateTime),//設定畫面的年月日
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//
//             new ListTile(
//               horizontalTitleGap: 10,
//               minLeadingWidth: 0,
//               leading: new Icon(Icons.search),
//               title: Text(
//                 text ?? "新增藥品名稱",
//                 style: TextStyle(fontSize: 18),
//               ),
//               onTap: () {
//                 _returnValueOfDrugText(context);
//               },
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     "",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//             new ListTile(
//               title: Text(
//                 "服藥模式",
//                 style: TextStyle(fontSize: 18),
//               ),
//               onTap: () {
//                 _returnValueOfTakedrugText(context);
//               },
//             ),
//             new ListTile(
//               title: Text(
//                 time.format(context),
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ]).toList(),
//         ),
//       ),
//     );
//   }
//
//   void _returnValueOfDrugText(BuildContext context) async {
//     final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SearchText(),
//         ));
//
//     setState(() {
//       text = result;
//     });
//   }
//
//   void _returnValueOfTakedrugText(BuildContext context) async {
//     final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MedicineMode(),
//         ));
//     setState(() {
//       time = result;
//       _fromDateTime = new DateTime(_fromDateTime.year, _fromDateTime.month,
//           _fromDateTime.day, time.hour, time.minute);
//       _toDateTime = new DateTime(_toDateTime.year, _toDateTime.month,
//           _toDateTime.day, time.hour, time.minute);
//     });
//   }
//
//   Future _showFromDatePicker(BuildContext context) async {
//     DateTime dateTimePicked = await showDatePicker(
//         context: context,
//         initialDate: _fromDateTime,
//         builder: (context, child) {
//           return Theme(
//             data: Theme.of(context).copyWith(
//               colorScheme: ColorScheme.light(
//                 primary: Color.fromRGBO(210, 180, 140, 1.0),
//                 // header background color
//                 onPrimary: Colors.black,
//                 // header text color
//                 onSurface: Colors.black, // body text color
//               ),
//               textButtonTheme: TextButtonThemeData(
//                 style: TextButton.styleFrom(
//                   primary:
//                   Color.fromRGBO(204, 119, 34, 1.0), // button text color
//                 ),
//               ),
//             ),
//             child: child,
//           );
//         },
//         firstDate: _fromDateTime.subtract(const Duration(days: 20000)),
//         lastDate: new DateTime(2033, 12, 31));
//
//     if (dateTimePicked != null) {
//       _fromDateTime = new DateTime(dateTimePicked.year, dateTimePicked.month,
//           dateTimePicked.day, time.hour, time.minute);
//       setState(() {
//         _fromDateTime = dateTimePicked;
//         // fromDate = dateTimePicked;
//         // return fromDate;
//       });
//     }
//   }
//
//   Future _showToDatePicker (BuildContext context) async {
//     DateTime dateTimePicked = await showDatePicker(
//         context: context,
//         initialDate: _toDateTime,
//         builder: (context, child) {
//           return Theme(
//             data: Theme.of(context).copyWith(
//               colorScheme: ColorScheme.light(
//                 primary: Color.fromRGBO(210, 180, 140, 1.0),
//                 // header background color
//                 onPrimary: Colors.black,
//                 // header text color
//                 onSurface: Colors.black, // body text color
//               ),
//               textButtonTheme: TextButtonThemeData(
//                 style: TextButton.styleFrom(
//                   primary:
//                   Color.fromRGBO(204, 119, 34, 1.0), // button text color
//                 ),
//               ),
//             ),
//             child: child,
//           );
//         },
//         firstDate: _toDateTime,
//         lastDate: new DateTime(2033, 12, 31));
//
//     if (dateTimePicked != null) {
//       _toDateTime = new DateTime(dateTimePicked.year, dateTimePicked.month,
//           dateTimePicked.day, time.hour, time.minute);
//       setState(() {
//         _toDateTime = dateTimePicked;
//         // toDate = dateTimePicked;
//         // return toDate;
//       });
//     }
//   }
//
// }
