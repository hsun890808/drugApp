import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/authHome/model/database_compare.dart';
import 'package:flutter1/authHome/model/time_entry.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter1/authHome/time_content/screens/search.dart';
import 'package:flutter1/helpers/device_input.dart';

class EditDrugB extends StatefulWidget {
  EditDrugB({Key key}) : super(key: key);

  @override
  _EditDrugBState createState() => _EditDrugBState();
}

class _EditDrugBState extends State<EditDrugB> {
  List<DrugItem> Remedios = List();
  DrugItem item;
  DatabaseReference itemRef;
  String _drugInfo;
  bool _isDeleting = false;

  // String drugText;

  DatabaseReference drugBdb = FirebaseDatabase.instance
      .reference()
      .child("device")
      .child(GetDeviceID.getDeviceID)
      .child("drugB");

  // readData()  {
  //   var drugText;
  //    FirebaseDatabase.instance.reference()
  //       .child("device").child(GetDeviceID.getDeviceID).child("drugB").once().then((DataSnapshot snapshot) {
  //   Map<dynamic, dynamic> values = snapshot.value;
  //   values.forEach((key, values) {
  //     drugText = values['drugText'];
  //     print("名稱：");
  //     print(drugText);
  //   });
  // });
  // return drugText;
  // }

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    item = DrugItem("", "");
    itemRef = database.reference().child('drugInfo');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
    DrugBText().readDrugBText();
    print("readDrugBText");
    print(DrugBText.drugBText);
  }

  _onEntryAdded(Event event) {
    if (!mounted) return; ////
    setState(() {
      Remedios.add(DrugItem.fromSnapshot(event.snapshot));
    });
  }


  _onEntryChanged(Event event) {
    var old = Remedios.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    if (!mounted) return; ////
    setState(() {
      Remedios[Remedios.indexOf(old)] = DrugItem.fromSnapshot(event.snapshot);
    });
  }

  Widget _createAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Color.fromRGBO(210, 180, 140, 1.0),
      elevation: 0,
      actions: [
        _isDeleting
            ? Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            right: 16.0,
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.redAccent,
            ),
            strokeWidth: 3,
          ),
        )
            : IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.redAccent,
            size: 36,
          ),
          onPressed: () async {
            setState(() {
              _isDeleting = true;
            });

            await drugBdb.remove();

            setState(() {
              _isDeleting = false;
            });

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(context),
      body: new Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: 100,
                child: StreamBuilder(
                  stream: StaticInfo.readItemsA(),
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      return FirebaseAnimatedList(
                        query: drugBdb,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          String drugName = snapshot.value['drugText'];
                          return Ink(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(
                                  "藥品名稱：",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                new Text(
                                  DrugBText.drugBText?? "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }

                    return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(204, 119, 34, 1.0),
                          ),
                        ));
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: FirebaseAnimatedList(
                  //使用FirebaseAnimatedList控制元件把訊息列表顯示出來
                  query: itemRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return Remedios[index]
                        .CSname
                        .contains(DrugBText.drugBText)
                        ? ListTile(
                      //顯示全部
                      title:Text("適應症",style: TextStyle(
                        fontSize: 28,
                      ),),
                      subtitle: Text(Remedios[index].use.toString(),
                        style: TextStyle(
                          fontSize: 24,
                        ),),
                    )
                        : new Container();
                  },
                ),
              ),
            ],
          )),
    );
  }
//
// void _returnValueOfTakedrugText(BuildContext context) async {
//   await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MedicineMode(),
//       ));
// }
}
