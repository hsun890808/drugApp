import 'package:cloud_firestore/cloud_firestore.dart';

  class Times {

    String id;
    DateTime fromDateTime;
    DateTime toDateTime;
    int active;
    String text;

    Times({ this.fromDateTime, this.toDateTime, this.active, this.text});

  }

final CollectionReference timeCollection = FirebaseFirestore.instance.collection('set_times');

  class Entry {
    static String userid;

    static Future<void> addItem({
      String drugText,
      DateTime fromDateTime,
      DateTime toDateTime,
      int active,
      int notificationId,
    }) async {
      DocumentReference documentReferencer =
      timeCollection.doc(userid).collection('items').doc();

      Map<String, dynamic> data = <String, dynamic>{
        'drugName': drugText,
        'fromDate': fromDateTime,
        'toDate' : toDateTime,
        'docID': documentReferencer.id,
        'active': active,
        'notificationId': notificationId,
      };

      await documentReferencer
          .set(data)
          .whenComplete(() => print("Note item added to the database"))
          .catchError((e) => print(e));
    }

////
    static Future<void> updateItem({
      DateTime dateTime,
      DateTime dateTime2,
      String drugText,
      String docId,
    }) async {
      DocumentReference documentReferencer =
      timeCollection.doc(userid).collection('items').doc(docId);

      Map<String, dynamic> data = <String, dynamic>{
        "drugName": drugText,
        'fromDate': dateTime,
        'toDate' : dateTime2,
      };

      await documentReferencer
          .update(data)
          .whenComplete(() => print("Note item updated in the database"))
          .catchError((e) => print(e));
    }

////
    static Stream<QuerySnapshot> readItems() {
      Query timeItemCollection =
      timeCollection.doc(userid).collection('items').orderBy('fromDate', descending: true); //排序

      return timeItemCollection.snapshots();
    }

    ////

    static Future<void> deleteItem({
      String docId,
    }) async {
      DocumentReference documentReferencer =
      timeCollection.doc(userid).collection('items').doc(docId);

      await documentReferencer
          .delete()
          .whenComplete(() => print('Note item deleted from the database'))
          .catchError((e) => print(e));
    }
    ////


    // static Future<DocumentSnapshot> getAlarmDetails(String docID) async {
    //   return await timeCollection.doc(userid).collection('items').doc(docID).get();
    // }

  }
////
//      Future<void> updateUserData(String dateTime) async {
//       return await timeCollection.doc(uid).set({
//          'fromDate': dateTime,
//        });
//      }
//
//  List<Times> _timeListFromSnapshot(QuerySnapshot snapshot) {
//    return snapshot.docs.map((doc) {
//     //print(doc.data);
//      return Times(
//      dateTime: doc.data()['dateTime'] ?? '',
//     );
//    }).toList();
//  }
// // user data from snapshots
// UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//   return UserData(
//     uid: uid,
//      dateTime: snapshot.data()['dateTime'],
//   );
//  }
//   }
  //
  // // get brews stream
  // Stream<List<Times>> get times {
  //   return timeCollection.snapshots()
  //       .map(_timeListFromSnapshot);
  // }
  //
  // // get user doc stream
  // Stream<UserData> get userData {
  //   return timeCollection.doc(uid).snapshots()
  //       .map(_userDataFromSnapshot);
  // }
