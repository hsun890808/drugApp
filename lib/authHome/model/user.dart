// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserInformation {
//   String documentID;
//   String email;
//   String name;
//   String password;
//
//   bool isAdmin;
//
//   UserInformation({
//     this.documentID,
//     this.email,
//     this.isAdmin,
//     this.name,
//     this.password,
//   });
//
//   factory UserInformation.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> Function() data = doc.data;
//
//     return UserInformation(
//       documentID: doc.id,
//       email: data()['email'] ?? '',
//       name: data()['name'] ?? '',
//       isAdmin: data()['isAdmin'] ?? false,
//     );
//   }
// }
