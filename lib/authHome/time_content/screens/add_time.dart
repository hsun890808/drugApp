// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class AddScreen extends StatelessWidget {
//   AddScreen({Key key, DateTime fromDateTime, DateTime toDateTime, @required this.onFromChanged, this.onToChanged})
//       : assert(onFromChanged != null),
//         fromDate = fromDateTime == null
//             ? new DateTime.now().millisecondsSinceEpoch
//             : new DateTime.utc(fromDateTime.year, fromDateTime.month, fromDateTime.day),
//         toDate = toDateTime == null
//             ? new DateTime.now().millisecondsSinceEpoch
//             : new DateTime.utc(toDateTime.year, toDateTime.month, toDateTime.day),
//         time = fromDateTime == null
//             ? new DateTime.now().millisecondsSinceEpoch
//             : new TimeOfDay(hour: fromDateTime.hour, minute: fromDateTime.minute),
//         super(key: key);
//
//   final DateTime fromDate;
//   final DateTime toDate;
//   final TimeOfDay time;
//   final ValueChanged<DateTime> onFromChanged;
//   final ValueChanged<DateTime> onToChanged;
//
//   //設定date time 的畫面
//   @override
//   Widget build(BuildContext context) {
//     return new Column(
//
//       children: ListTile.divideTiles(context: context, tiles: [
//         new ListTile(
//           horizontalTitleGap: 10,
//           minLeadingWidth: 0,
//             onTap: (() => _showFromDatePicker(context)),
//           leading: new Icon(Icons.today, size: 22),
//           title: Text("開始日期", style: TextStyle(fontSize: 18)),
//           trailing: Text(
//                     new DateFormat('yyyy年 MM月 dd日').format(fromDate),//設定畫面的年月日
//                     style: TextStyle(fontSize: 18),
//                   ),
//           ),
//
//         new ListTile(
//           horizontalTitleGap: 10,
//           minLeadingWidth: 0,
//           onTap: (() => _showToDatePicker(context)),
//           leading: new Icon(Icons.today, size: 22),
//           title: Text("結束日期", style: TextStyle(fontSize: 18)),
//           trailing: Text(
//             new DateFormat('yyyy年 MM月 dd日').format(toDate),//設定畫面的年月日
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//
//         // new ListTile(
//         //   horizontalTitleGap: 10,
//         //   minLeadingWidth: 0,
//         //   onTap: (() => _showTimePicker(context)),
//         //   leading: new Icon(Icons.access_alarms_rounded, size: 22),
//         //   title: Text("新增服藥時間", style: TextStyle(fontSize: 18)),
//         //   trailing: Text(
//         //     time.format(context),
//         //     style: TextStyle(fontSize: 18),
//         //   ), //設定畫面的時間
//         // ),
//       ]).toList(),
//     );
//   }
//
//   Future _showFromDatePicker(BuildContext context) async {
//     DateTime dateTimePicked = await showDatePicker(
//         context: context,
//         initialDate: fromDate,
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
//                       Color.fromRGBO(204, 119, 34, 1.0), // button text color
//                 ),
//               ),
//             ),
//             child: child,
//           );
//         },
//         firstDate: fromDate.subtract(const Duration(days: 20000)),
//         lastDate: new DateTime(2033, 12, 31));
//
//     if (dateTimePicked != null) {
//
//       onFromChanged(new DateTime(dateTimePicked.year, dateTimePicked.month,
//           dateTimePicked.day, time.hour, time.minute));
//     }
//   }
//   Future _showToDatePicker (BuildContext context) async {
//     DateTime dateTimePicked = await showDatePicker(
//         context: context,
//         initialDate: fromDate,
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
//         firstDate: fromDate,
//         lastDate: new DateTime(2033, 12, 31));
//
//     if (dateTimePicked != null) {
//       onToChanged(new DateTime(dateTimePicked.year, dateTimePicked.month,
//           dateTimePicked.day, time.hour, time.minute));
//     }
//   }
//
//   Future _showTimePicker(BuildContext context) async {
//     TimeOfDay timeOfDay = await showTimePicker(
//         context: context,
//         initialTime: time,
//         builder: (context, child) {
//           return Theme(
//             data: Theme.of(context).copyWith(
//               colorScheme: ColorScheme.light(
//                 primary: Color.fromRGBO(227, 137, 2, 1.0),
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
//     );
//     if (timeOfDay != null) {
//       onFromChanged(new DateTime(
//           fromDate.year, fromDate.month, fromDate.day, timeOfDay.hour, timeOfDay.minute));
//       onToChanged(new DateTime(
//           toDate.year, toDate.month, toDate.day, timeOfDay.hour, timeOfDay.minute));
//     }
//   }
//
// }
