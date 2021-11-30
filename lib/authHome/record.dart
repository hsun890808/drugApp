//當按下Home按鈕時，出現的介面
import 'package:flutter/material.dart';
import '../helpers/Constants.dart';

class Record extends StatefulWidget {
  Record({Key key}) : super(key: key);

  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  List<String> strings = new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children:
        strings.map((String string) {
          return new Row(
            children: [
              new Text(string)
            ],
          );
        }).toList(),
      ),

    );
  }
}