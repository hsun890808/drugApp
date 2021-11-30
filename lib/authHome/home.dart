//當按下Home按鈕時，出現的介面
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/authHome/model/time_entry.dart';
import 'package:flutter1/authHome/set_time.dart';
import 'package:flutter1/helpers/device_input.dart';
import 'package:flutter_countdown_timer/index.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  CountdownTimerController controller;
  TimeOfDay n = TimeOfDay.now();
  int _endTime = new DateTime.now().millisecondsSinceEpoch ;
  // int endTime = DateTime.now().millisecondsSinceEpoch +
  //     Duration(seconds: 30).inMilliseconds +
  //     Duration(minutes: 0).inMilliseconds;

  DatabaseReference mainReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    controller =
        CountdownTimerController(endTime: _endTime, onEnd: onEnd, vsync: this);
    GetDeviceID().getd();
    mainReference =
        FirebaseDatabase.instance.reference().child("device").child(userid);
    drugAdb = mainReference.child("drugA");
    drugBdb = mainReference.child("drugB");
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  void onEnd() {
    print('時間到');
  }

  _HomeState() {
    mainReference.onChildAdded.listen(_onEntryAdded);
  }

  List<DrugARealtime> drugASaves = new List();
  List<DrugBRealtime> drugBSaves = new List();

  @override
  Widget build(BuildContext context) {
    final drugA = Ink(
        color: Color.fromRGBO(210, 180, 140, 1.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: StaticInfo.readItemsA(),
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong'); //若連不上realtime會顯示
                    } else if (snapshot.hasData &&
                        snapshot.data.snapshot.value != null) {
                      return FirebaseAnimatedList(
                        query: drugAdb,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          String drugName = snapshot.value['drugText'];
                          print("藥品名稱：" + drugName);
                          DateTime fromDate =
                              (DateTime.parse(snapshot.value['fromDate']));
                          DateTime toDate =
                              (DateTime.parse(snapshot.value['toDate']));
                          String timeString =snapshot.value['time'];
                          TimeOfDay time = TimeOfDay(hour:int.parse(timeString.split(":")[0]),minute: int.parse(timeString.split(":")[1]));

                          int difmin = Duration(hours: time.hour - n.hour).inMilliseconds;
                          int difsec = Duration(minutes: time.minute - n.minute).inMilliseconds;
                          print("時間倒數：");
                          print(difmin);
                          print(difsec);
                          int endTime = _endTime + difmin + difsec;

                          return new InkWell(
                            child: Column(
                              children: [
                                new Text("下次吃藥時間",
                                    style: TextStyle(fontSize: 18)),
                                new Text(
                                  "藥品名稱：",
                                  textAlign: TextAlign.left,
                                ),
                                new Text(
                                  snapshot.value['drugText'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                CountdownTimer(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    color: Colors.red,
                                  ),
                                  onEnd: onEnd,
                                  endTime: endTime,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Text("尚未新增吃藥時間");
                    }
                  },
                ),
              ),
            ),
          ],
        ));

    final drugB = Ink(
        color: Color.fromRGBO(210, 180, 140, 1.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: StaticInfo.readItemsB(),
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong'); //若連不上realtime會顯示
                    } else if (snapshot.hasData &&
                        snapshot.data.snapshot.value != null) {
                      return FirebaseAnimatedList(
                        query: drugBdb,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          String drugName = snapshot.value['drugText'];
                          print("藥品名稱：" + drugName);
                          DateTime fromDate =
                          (DateTime.parse(snapshot.value['fromDate']));
                          DateTime toDate =
                          (DateTime.parse(snapshot.value['toDate']));
                          String timeString =snapshot.value['time'];
                          TimeOfDay time = TimeOfDay(hour:int.parse(timeString.split(":")[0]),minute: int.parse(timeString.split(":")[1]));

                          int difmin = Duration(hours: time.hour - n.hour).inMilliseconds;
                          int difsec = Duration(minutes: time.minute - n.minute).inMilliseconds;
                          print("時間倒數：");
                          print(difmin);
                          print(difsec);
                          int endTime1 = _endTime + difmin + difsec;

                          return new InkWell(
                            child: Column(
                              children: [
                                new Text("下次吃藥時間",
                                    style: TextStyle(fontSize: 18)),
                                new Text(
                                  "藥品名稱：",
                                  textAlign: TextAlign.left,
                                ),
                                new Text(
                                  snapshot.value['drugText'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                CountdownTimer(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    color: Colors.red,
                                  ),
                                  onEnd: onEnd,
                                  endTime: endTime1,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Text("尚未新增吃藥時間");
                    }
                  },
                ),
              ),
            ),
          ],
        ));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),

            children: [
              drugA,
              drugB,

            ],
          ),
          // child: centreSection()),
        ),
      ),
    );
  }


  // @override
  // Widget countDown() {
  //   return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         CountdownTimer(
  //           textStyle: TextStyle(
  //             fontSize: 30,
  //             color: Colors.red,
  //           ),
  //           onEnd: onEnd,
  //           endTime: endTime,
  //         ),
  //         CountdownTimer(
  //           controller: controller,
  //           widgetBuilder: (_, CurrentRemainingTime time) {
  //             if (time == null) {
  //               return Text('Game over');
  //             }
  //             return Text(
  //                 'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
  //           },
  //         ),
  //       ],
  //     );
  // }

  @override
  Widget centreSection() {
    return Container(
      height: 600,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          childAspectRatio: 0.65,
        ),
        children: [
          Container(
              color: Color.fromRGBO(210, 180, 140, 1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: const Text(
                      "下次吃藥時間",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  StreamBuilder(
                    stream: StaticInfo.readItemsA(),
                    builder: (context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong'); //若連不上realtime會顯示
                      } else if (snapshot.hasData &&
                          snapshot.data.snapshot.value != null) {
                        return FirebaseAnimatedList(
                          query: drugAdb,
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            String drugName = snapshot.value['drugText'];
                            print("藥品名稱：" + drugName);
                            DateTime fromDate =
                                (DateTime.parse(snapshot.value['fromDate']));
                            DateTime toDate =
                                (DateTime.parse(snapshot.value['toDate']));
                            var timeInMilliSeconds =
                                (snapshot.value['time'].seconds * 1000);

                            return new InkWell(
                              child: Column(
                                children: [
                                  new Text(
                                    "藥品名稱：",
                                    textAlign: TextAlign.left,
                                  ),
                                  new Text(
                                    snapshot.value['drugText'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  CountdownTimer(
                                    textStyle: TextStyle(
                                      fontSize: 30,
                                      color: Colors.red,
                                    ),
                                    onEnd: onEnd,
                                    endTime: timeInMilliSeconds,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Text("尚未新增吃藥時間");
                      }
                    },
                  ),
                ],
              )),
          Container(
            color: Color.fromRGBO(210, 180, 140, 1.0),
            child: Center(
              child: const Text(
                "下次吃藥時間",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Container(
            color: Color.fromRGBO(210, 180, 140, 1.0),
            child: Center(
              child: const Text(
                "下次吃藥時間",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Container(
            color: Color.fromRGBO(210, 180, 140, 1.0),
            child: Center(
              child: const Text(
                "下次吃藥時間",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onEntryAdded(Event event) {
    if (!mounted) return; ////
    setState(() {
      userid = FirebaseAuth.instance.currentUser.uid;
       n = TimeOfDay.now();
      drugASaves.add(new DrugARealtime.fromSnapshot(event.snapshot));
      drugASaves
          .sort((we1, we2) => we1.fromDateTime.compareTo(we2.fromDateTime));

      drugBSaves.add(new DrugBRealtime.fromSnapshot(event.snapshot));
      drugBSaves
          .sort((we1, we2) => we1.fromDateTime.compareTo(we2.fromDateTime));

    });
  }
}