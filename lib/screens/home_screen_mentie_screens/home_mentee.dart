import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');
final CollectionReference collectionUser2 =
    FirebaseFirestore.instance.collection('mentees');

class HomeMentee extends StatefulWidget {
  @override
  _HomeMenteeState createState() => _HomeMenteeState();
}

IconData icon1 = Icons.check_circle_outline_rounded;
IconData icon2 = Icons.check_circle_outline_rounded;
IconData icon3 = Icons.check_circle_outline_rounded;
IconData icon4 = Icons.check_circle_outline_rounded;

class _HomeMenteeState extends State<HomeMentee> {
  final _auth = FirebaseAuth.instance;
  String mentor = "";
  String task1 = "";
  String task2 = "";
  String task3 = "";
  String task4 = "";
  int stage = 0;
  String t1 = "-";
  String t2 = "-";
  String t3 = "-";
  String t4 = "-";
  Color color1 = Colors.grey;
  Color color2 = Colors.grey;
  Color color3 = Colors.grey;
  Color color4 = Colors.grey;
  int tasks_done = 0;
  int total_tasks = 4;
  Color text_color1 = Colors.grey.shade900;
  Color text_color2 = Colors.grey.shade900;
  Color text_color3 = Colors.grey.shade900;
  Color text_color4 = Colors.grey.shade900;

  void checkColors() {
    setState(() {
      if (t1 == "+") color1 = Colors.green;
      if (t2 == "+") color2 = Colors.green;
      if (t3 == "+") color3 = Colors.green;
      if (t4 == "+") color4 = Colors.green;
    });
  }

  void checkLevelBeginning() {
    setState(() {
      if (t1 == "+") tasks_done++;
      if (t2 == "+") tasks_done++;
      if (t3 == "+") tasks_done++;
      if (t4 == "+") tasks_done++;
    });
  }

  Future<void> mentorInfos() async {
    var collection = collectionUser;
    var docSnapshot = await collection.doc(mentor).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
        task1 = data?['task1']; // <-- The value you want to retrieve.
        task2 = data?['task2'];
        task3 = data?['task3'];
        task4 = data?['task4'];
        t1 = data?['t1']; // <-- The value you want to retrieve.
        t2 = data?['t2'];
        t3 = data?['t3'];
        t4 = data?['t4'];
        stage = data?['stage'];
      });

      //print(_mentorName);
      // Call setState if needed.
    }
  }

  Future<void> menteeInfos() async {
    var collection = collectionUser2;
    var docSnapshot = await collection.doc(loggedInUser.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
        mentor = data?['mentor'];
      });

      //print(_mentorName);
      // Call setState if needed.
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    Future.delayed(Duration(milliseconds: 500), () {
      menteeInfos();
      Future.delayed(Duration(milliseconds: 500), () {
        mentorInfos();
        print('delayed execution');
        Future.delayed(Duration(milliseconds: 500), () {
          checkColors();
          checkLevelBeginning();
          print('delayed execution');
        });
      });
    });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("images/Blob3.png"),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                ),
                child: Center(
                  child: Text(
                    "My Tasks",
                    style: TextStyle(
                      height: MediaQuery.of(context).size.height * 0.0011,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.13,
                            top: MediaQuery.of(context).size.height * 0.17),
                        child: LiquidCustomProgressIndicator(
                          value: tasks_done / total_tasks,
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          backgroundColor: Colors.blue[100],
                          direction: Axis.vertical,
                          shapePath: _buildBoatPath(),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.145,
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          Image.asset("images/tree.png"),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.11,
                          ),
                          Text(
                            "Stage: $stage",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Icon(
                              icon1,
                              color: color1,
                              size: 30,
                            ),
                          ),
                          Text(
                            task1,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: text_color1,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Icon(
                              icon2,
                              color: color2,
                              size: 30,
                            ),
                          ),
                          Text(
                            task2,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: text_color2,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Icon(
                              icon3,
                              color: color3,
                              size: 30,
                            ),
                          ),
                          Text(
                            task3,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: text_color1,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Icon(
                              icon4,
                              color: color4,
                              size: 30,
                            ),
                          ),
                          Text(
                            task4,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: text_color4,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Path _buildBoatPath() {
    return Path()
      ..lineTo(0, 130)
      ..lineTo(40, 130)
      ..lineTo(40, 0)
      ..close();
  }
}
