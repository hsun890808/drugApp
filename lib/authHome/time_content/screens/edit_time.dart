// import 'package:flutter/material.dart';
// import 'package:flutter1/authHome/model/time_firebase.dart';
// import 'package:flutter1/authHome/time_content/edit_time_form.dart';
// import 'package:flutter1/authHome/time_content/screens/edit_drugA.dart';
//
// class EditScreen extends StatefulWidget {
//   final String currentTitle;
//   final String documentId;
//
//   EditScreen({
//     this.currentTitle,
//     this.documentId,
//   });
//
//   @override
//   _EditScreenState createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//   final FocusNode _titleFocusNode = FocusNode();
//
//   final FocusNode _descriptionFocusNode = FocusNode();
//
//   bool _isDeleting = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _titleFocusNode.unfocus();
//         _descriptionFocusNode.unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromRGBO(210, 180, 140, 1.0),
//           elevation: 0,
//           actions: [
//             _isDeleting
//                 ? Padding(
//                     padding: const EdgeInsets.only(
//                       top: 10.0,
//                       bottom: 10.0,
//                       right: 16.0,
//                     ),
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         Colors.redAccent,
//                       ),
//                       strokeWidth: 3,
//                     ),
//                   )
//                 : IconButton(
//                     icon: Icon(
//                       Icons.delete,
//                       color: Colors.redAccent,
//                       size: 32,
//                     ),
//                     onPressed: () async {
//                       setState(() {
//                         _isDeleting = true;
//                       });
//
//                       await Entry.deleteItem(
//                         docId: widget.documentId,
//                       );
//
//                       setState(() {
//                         _isDeleting = false;
//                       });
//
//                       Navigator.of(context).pop();
//                     },
//                   ),
//           ],
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(
//               left: 16.0,
//               right: 16.0,
//               bottom: 20.0,
//             ),
//             child: EditDrugA(
//               documentId: widget.documentId,
//               currentTitle: widget.currentTitle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
