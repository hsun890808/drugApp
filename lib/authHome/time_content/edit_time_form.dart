// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter1/authHome/model/time_firebase.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter1/authHome/time_content/screens/med_mode.dart';
// import 'package:flutter1/authHome/time_content/screens/edit_time.dart';
// import 'screens/add_time.dart';
//
// class EditItemForm extends StatefulWidget {
//   final String currentTitle;
//   final String documentId;
//
//   const EditItemForm({
//     this.currentTitle,
//     this.documentId,
//   });
//
//   @override
//   _EditItemFormState createState() => _EditItemFormState();
// }
//
// class _EditItemFormState extends State<EditItemForm> {
//   final _editItemFormKey = GlobalKey<FormState>();
//
//   DateTime _fromDateTime = new DateTime.now();
//   DateTime _toDateTime = new DateTime.now();
//
//   bool _isProcessing = false;
//   bool _isDeleting = false;
//
//   TextEditingController _titleController;
//
//   DatabaseReference drugAdb = FirebaseDatabase.instance.reference().child("drugA");
//
//   @override
//   void initState() {
//     _titleController = TextEditingController(
//       text: widget.currentTitle,
//     );
//
//     super.initState();
//   }
//
//   Widget _createAppBar(BuildContext context) {
//     return new AppBar(
//       backgroundColor: Color.fromRGBO(210, 180, 140, 1.0),
//       elevation: 0,
//       actions: [
//         _isDeleting
//             ? Padding(
//                 padding: const EdgeInsets.only(
//                   top: 10.0,
//                   bottom: 10.0,
//                   right: 16.0,
//                 ),
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     Colors.redAccent,
//                   ),
//                   strokeWidth: 3,
//                 ),
//               )
//             : IconButton(
//                 icon: Icon(
//                   Icons.delete,
//                   color: Colors.redAccent,
//                   size: 32,
//                 ),
//                 onPressed: () async {
//                   setState(() {
//                     _isDeleting = true;
//                   });
//
//                   await drugAdb.remove();
//
//                   setState(() {
//                     _isDeleting = false;
//                   });
//
//                   Navigator.of(context).pop();
//                 },
//               ),
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
//               horizontalTitleGap: 0,
//               contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
//               // title: new EditScreen(
//               //   fromDateTime: _fromDateTime,
//               //   toDateTime: _toDateTime,
//               //   onFromChanged: (fromDateTime) => setState(() => _fromDateTime = fromDateTime),
//               //   onToChanged: (toDateTime) => setState(() => _toDateTime = toDateTime),
//               // ),
//             ),
//             // new Form(
//             //     key: _addItemFormKey,
//             ListTile(
//               horizontalTitleGap: 10,
//               minLeadingWidth: 0,
//               leading: new Icon(Icons.search),
//               title: Text(
//                 "藥品名稱",
//                 style: TextStyle(fontSize: 18),
//               ),
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
//             ListTile(
//               title: Text(
//                 "服藥模式",
//                 style: TextStyle(fontSize: 18),
//               ),
//               onTap: () {
//                 // _returnValueOfTakedrugText(context);
//               },
//             ),
//           ]).toList(),
//         ),
//       ),
//     );
//   }
// //
// // void _returnValueOfTakedrugText(BuildContext context) async {
// //   await Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => MedicineMode(),
// //       ));
// // }
// }
