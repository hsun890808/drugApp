import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter1/authHome/time_content/screens/add_time.dart';

import '../add_time_form.dart';

class SearchText extends StatefulWidget {
  @override
  SearchTextState createState() => SearchTextState();
}

class SearchTextState extends State<SearchText> {
  List<DrugItem> Remedios = List();
  DrugItem item;
  DatabaseReference itemRef;
  TextEditingController _drugTextController = new TextEditingController();
  String filter;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = DrugItem("", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('drugInfo');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
    _drugTextController.addListener(() {
      if (!mounted) return; ////
      setState(() {
        filter = _drugTextController.text;
      });
    });
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

  // void handleSubmit() {
  //   final FormState form = formKey.currentState;
  //
  //   if (form.validate()) {
  //     form.save();
  //     form.reset();
  //     itemRef.push().set(item.toJson());
  //   }
  // }

  @override
  void dispose() {
    _drugTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(210, 180, 140, 1.0),
        actions: [
          new FlatButton(
            child: new Text('完成',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white, fontSize: 20.0)),
            onPressed: () {
              _sendDataBack(context);
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          new TextField(
            cursorColor: Colors.black,
            autocorrect: false,
            controller: _drugTextController,
            decoration: InputDecoration(
              // focusedBorder: UnderlineInputBorder(
              //   borderSide: BorderSide(color: Colors.black),
              // ),

              prefixIcon: const Icon
                (Icons.search,
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                onPressed: _drugTextController.clear,
                icon: Icon(Icons.clear),
              ),
              border: InputBorder.none,
              labelText: "請輸入藥品名稱",
              labelStyle: TextStyle(color: Colors.black),
              // hintText: '請輸入藥品名稱',
            ),
            // onChanged: (v) {
            //   setState(() {
            //     query = v;
            //     setResults(query);
            //   });
            // },
          ),
          Flexible(
            child: FirebaseAnimatedList(
              //使用FirebaseAnimatedList控制元件把訊息列表顯示出來
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return Remedios[index].use.contains(filter.toString()) ||
                        Remedios[index].CSname.contains(filter.toString())
                    ? ListTile(
                        //顯示全部
                        leading: filter.isEmpty
                            ? const Icon(null)
                            : Icon(Icons.add_circle_outline),
                        title: filter.isEmpty
                            ? Text("")
                            : Text(Remedios[index].CSname.toString()),
                        subtitle: filter.isEmpty
                            ? Container()
                            : Text(Remedios[index].use.toString()),
                        onTap: () {
                          setState(() {
                            _drugTextController.text = Remedios[index].CSname;
                          });
                        },
                      )
                    : new Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  // get the text in the TextField and send it back to the FirstScreen
  void _sendDataBack(BuildContext context) {
    String textToSendBack = _drugTextController.text;
    Navigator.pop(context, textToSendBack);
  }
}

class DrugItem {   //藥品資料庫
  String key;
  String CSname;
  String use;

  DrugItem(this.CSname, this.use);

  DrugItem.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        CSname = snapshot.value["中文品名"],
        use = snapshot.value["適應症"];

  toJson() {
    return {
      "CSname": CSname,
      "use": use,
    };
  }
}
