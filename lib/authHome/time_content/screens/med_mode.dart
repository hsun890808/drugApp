import 'package:flutter/material.dart';

class MedicineMode extends StatefulWidget {
  @override
  MedicineModeState createState() => MedicineModeState();
}

class MedicineModeState extends State<MedicineMode> {

  bool selectedRadio0, selectedRadio1, selectedRadio2;
  // TimeOfDay time;
  TimeOfDay _time = new TimeOfDay.now();
  TimeOfDay _time1 = new TimeOfDay.now();
  TimeOfDay _time2 = new TimeOfDay.now();


  @override
  void initState() {
    super.initState();
    RadioValue.radiovalue = 0;
    selectedRadio0 = true;
    selectedRadio1 = false;
    selectedRadio2 = false;
  }

  void radiofunc(val) {
    if (val == 0) {
      selectedRadio0 = true;
      selectedRadio1 = false;
      selectedRadio2 = false;

      print("1個設定時間");
    } else if (val == 1) {
      selectedRadio0 = true;
      selectedRadio1 = true;
      selectedRadio2 = false;
      print("2個設定時間");
    } else if(val == 2){
      selectedRadio0 = true;
      selectedRadio1 = true;
      selectedRadio2 = true;
      print("3個設定時間");
    }
    setState(() {
      RadioValue.radiovalue = val;
    });
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
      body: new Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Text(
              "服藥模式",
              style: TextStyle(fontSize: 22),
            ),
            RadioListTile(
              value: 0,
              onChanged: radiofunc,
              groupValue: RadioValue.radiovalue,
              title: Text("一天1次"),
              activeColor: Color.fromRGBO(204, 119, 34, 1.0)
              // selected: this.selectedRadio0 == 0,
            ),
            RadioListTile(
              value: 1,
              onChanged: radiofunc,
              groupValue: RadioValue.radiovalue,
              title: Text("一天2次"),
                activeColor: Color.fromRGBO(204, 119, 34, 1.0)
              // selected: this.selectedRadio1 == 1,
            ),
            RadioListTile(
              value: 2,
              onChanged: radiofunc,
              groupValue: RadioValue.radiovalue,
              title: Text("一天3次"),
                activeColor: Color.fromRGBO(204, 119, 34, 1.0)
              // selected: this.selectedRadio2 == 2,
            ),


            Visibility(
              visible: selectedRadio0,
              child: new ListTile(
                horizontalTitleGap: 10,
                minLeadingWidth: 0,
                onTap: (() => _showTimePicker(context)),
                leading: new Icon(Icons.access_alarms_rounded, size: 22),
                title: Text("新增服藥時間", style: TextStyle(fontSize: 18)),
                trailing: Text(
                  _time.format(context),
                  style: TextStyle(fontSize: 18),
                ), //設定畫面的時間
              ),
            ),

            Visibility(
              visible: selectedRadio1,
              child: new ListTile(
                horizontalTitleGap: 10,
                minLeadingWidth: 0,
                onTap: (() => _showTimePicker1(context)),
                leading: new Icon(Icons.access_alarms_rounded, size: 22),
                title: Text("新增服藥時間", style: TextStyle(fontSize: 18)),
                trailing: Text(
                  _time1.format(context),
                  style: TextStyle(fontSize: 18),
                ), //設定畫面的時間
              ),
            ),

            Visibility(
              visible: selectedRadio2,
              child: new ListTile(
                horizontalTitleGap: 10,
                minLeadingWidth: 0,
                onTap: (() => _showTimePicker2(context)),
                leading: new Icon(Icons.access_alarms_rounded, size: 22),
                title: Text("新增服藥時間", style: TextStyle(fontSize: 18)),
                trailing: Text(
                  _time2.format(context),
                  style: TextStyle(fontSize: 18),
                ), //設定畫面的時間
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future _showTimePicker(BuildContext context) async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(227, 137, 2, 1.0),
              // header background color
              onPrimary: Colors.black,
              // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color.fromRGBO(204, 119, 34, 1.0), // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (timeOfDay != null) {
      setState(() {
        _time = timeOfDay;
        // time = timeOfDay;
        // return time;
      });
    }
  }

  Future _showTimePicker1(BuildContext context) async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: _time1,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(227, 137, 2, 1.0),
              // header background color
              onPrimary: Colors.black,
              // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color.fromRGBO(204, 119, 34, 1.0), // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (timeOfDay != null) {
      setState(() {
        _time1 = timeOfDay;
      });
    }
  }

  Future _showTimePicker2(BuildContext context) async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: _time2,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(227, 137, 2, 1.0),
              // header background color
              onPrimary: Colors.black,
              // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color.fromRGBO(204, 119, 34, 1.0), // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (timeOfDay != null) {
      setState(() {
        _time2 = timeOfDay;
      });
    }
  }

  void _sendDataBack(BuildContext context) {
    List<dynamic> list = new List<dynamic>();

      list.add(_time);
      list.add(_time1);
      list.add(_time2);

    print("時間");
    print(list);
    Navigator.pop(context, list);
  }
}

class RadioValue{
  static int radiovalue;
  static bool selectedRadio0=false;
  static bool selectedRadio1=false;
  static bool selectedRadio2=false;

}

