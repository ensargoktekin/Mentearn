import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:mentearn/screens/home_screen_mentor_screens/add_tasks.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');

class HomeMentor extends StatefulWidget {
  @override
  _HomeMentorState createState() => _HomeMentorState();
}

IconData icon1 = Icons.check_circle_outline_rounded;
IconData icon2 = Icons.check_circle_outline_rounded;
IconData icon3 = Icons.check_circle_outline_rounded;
IconData icon4 = Icons.check_circle_outline_rounded;

class _HomeMentorState extends State<HomeMentor> {
  final _auth = FirebaseAuth.instance;
  Color text_color1 = Colors.grey.shade900;
  Color text_color2 = Colors.grey.shade900;
  Color text_color3 = Colors.grey.shade900;
  Color text_color4 = Colors.grey.shade900;
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

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                  "all tasks for this stage are completed, please assign new tasks for next stage"),
            ));
  }

  void showAlert2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("add new tasks to get started!"),
            ));
  }

  void checkColors() {
    setState(() {
      if (t1 == "+") color1 = Colors.orange;
      if (t2 == "+") color2 = Colors.orange;
      if (t3 == "+") color3 = Colors.orange;
      if (t4 == "+") color4 = Colors.orange;
    });
  }

  void checkState() {
    if (t1 == "+" && t2 == "+" && t3 == "+" && t4 == "+") {
      Future.delayed(Duration.zero, () => showAlert(context));
    }
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
    var docSnapshot = await collection.doc(loggedInUser.email).get();
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
      if (stage == 0) {
        Future.delayed(Duration.zero, () => showAlert2(context));
      }

      //print(_mentorName);
      // Call setState if needed.
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    Future.delayed(Duration(milliseconds: 500), () {
      mentorInfos();
      print('delayed execution');
      Future.delayed(Duration(milliseconds: 500), () {
        checkColors();
        checkLevelBeginning();
        print('delayed execution');
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
              image: AssetImage("images/mentor_blob.png"),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.12,
                        left: MediaQuery.of(context).size.width * 0.12),
                    child: Text(
                      "Tasks\nList",
                      style: TextStyle(
                        height: MediaQuery.of(context).size.height * 0.0011,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AddTasks.id);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.12,
                          top: MediaQuery.of(context).size.height * 0.08,
                          right: MediaQuery.of(context).size.width * 0.07),
                      child: ClipRRect(
                        child: Image.asset("images/add_task.png"),
                      ),
                    ),
                  )
                ],
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
                          valueColor: AlwaysStoppedAnimation(Colors.orange),
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
                            child: FlatButton(
                                onPressed: () async {
                                  await collectionUser
                                      .doc(loggedInUser.email.toString())
                                      .update({
                                    't1': '+',
                                  });
                                  setState(() {
                                    if (t1 == "-") tasks_done++;
                                    t1 = "+";
                                    checkColors();
                                    checkState();
                                    /*if (color1 == Colors.grey) {
                                      tasks_done += 1;
                                      color1 = Colors.orange;
                                      text_color1 = Colors.grey.shade400;
                                    } else if (color1 == Colors.orange) {
                                      tasks_done -= 1;
                                      color1 = Colors.grey;
                                      text_color1 = Colors.grey.shade900;
                                    }*/
                                  });
                                },
                                child: Icon(
                                  icon1,
                                  color: color1,
                                  size: 30,
                                )),
                          ),
                          FlatButton(
                              onPressed: () async {
                                await collectionUser
                                    .doc(loggedInUser.email.toString())
                                    .update({
                                  't1': '+',
                                });
                                setState(() {
                                  if (t1 == "-") tasks_done++;
                                  t1 = "+";
                                  checkColors();
                                  checkState();
                                  /*if (color1 == Colors.grey) {
                                    tasks_done += 1;
                                    color1 = Colors.orange;
                                    text_color1 = Colors.grey.shade400;
                                  } else if (color1 == Colors.orange) {
                                    tasks_done -= 1;
                                    color1 = Colors.grey;
                                    text_color1 = Colors.grey.shade900;
                                  }*/
                                });
                              },
                              child: Text(
                                task1,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: text_color1,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: FlatButton(
                                onPressed: () async {
                                  await collectionUser
                                      .doc(loggedInUser.email.toString())
                                      .update({
                                    't2': '+',
                                  });
                                  setState(() {
                                    if (t2 == "-") tasks_done++;
                                    t2 = "+";
                                    checkColors();
                                    checkState();
                                    /*if (color2 == Colors.grey) {
                                      tasks_done += 1;
                                      color2 = Colors.orange;
                                      text_color2 = Colors.grey.shade400;
                                    } else if (color2 == Colors.orange) {
                                      tasks_done -= 1;
                                      color2 = Colors.grey;
                                      text_color2 = Colors.grey.shade900;
                                    }*/
                                  });
                                },
                                child: Icon(
                                  icon2,
                                  color: color2,
                                  size: 30,
                                )),
                          ),
                          FlatButton(
                              onPressed: () async {
                                await collectionUser
                                    .doc(loggedInUser.email.toString())
                                    .update({
                                  't2': '+',
                                });
                                setState(() {
                                  if (t2 == "-") tasks_done++;
                                  t2 = "+";
                                  checkColors();
                                  checkState();
                                  /*if (color2 == Colors.grey) {
                                    tasks_done += 1;
                                    color2 = Colors.orange;
                                    text_color2 = Colors.grey.shade400;
                                  } else if (color2 == Colors.orange) {
                                    tasks_done -= 1;
                                    color2 = Colors.grey;
                                    text_color2 = Colors.grey.shade900;
                                  }*/
                                });
                              },
                              child: Text(
                                task2,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: text_color2,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: FlatButton(
                                onPressed: () async {
                                  await collectionUser
                                      .doc(loggedInUser.email.toString())
                                      .update({
                                    't3': '+',
                                  });
                                  setState(() {
                                    if (t3 == "-") tasks_done++;
                                    t3 = "+";
                                    checkColors();
                                    checkState();
                                    /*if (color3 == Colors.grey) {
                                      tasks_done += 1;
                                      color3 = Colors.orange;
                                      text_color3 = Colors.grey.shade400;
                                    } else if (color3 == Colors.orange) {
                                      tasks_done -= 1;
                                      color3 = Colors.grey;
                                      text_color3 = Colors.grey.shade900;
                                    }*/
                                  });
                                },
                                child: Icon(
                                  icon3,
                                  color: color3,
                                  size: 30,
                                )),
                          ),
                          FlatButton(
                              onPressed: () async {
                                await collectionUser
                                    .doc(loggedInUser.email.toString())
                                    .update({
                                  't3': '+',
                                });
                                setState(() {
                                  if (t3 == "-") tasks_done++;
                                  t3 = "+";
                                  checkColors();
                                  checkState();
                                  /*if (color3 == Colors.grey) {
                                    tasks_done += 1;
                                    color3 = Colors.orange;
                                    text_color3 = Colors.grey.shade400;
                                  } else if (color3 == Colors.orange) {
                                    tasks_done -= 1;
                                    color3 = Colors.grey;
                                    text_color3 = Colors.grey.shade900;
                                  }*/
                                });
                              },
                              child: Text(
                                task3,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: text_color3,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: FlatButton(
                                onPressed: () async {
                                  await collectionUser
                                      .doc(loggedInUser.email.toString())
                                      .update({
                                    't4': '+',
                                  });
                                  setState(() {
                                    if (t4 == "-") tasks_done++;
                                    t4 = "+";
                                    checkColors();
                                    checkState();
                                    /*if (color4 == Colors.grey) {
                                      tasks_done += 1;
                                      color4 = Colors.orange;
                                      text_color4 = Colors.grey.shade400;
                                    } else if (color4 == Colors.orange) {
                                      tasks_done -= 1;
                                      color4 = Colors.grey;
                                      text_color4 = Colors.grey.shade900;
                                    }*/
                                  });
                                },
                                child: Icon(
                                  icon4,
                                  color: color4,
                                  size: 30,
                                )),
                          ),
                          FlatButton(
                              onPressed: () async {
                                await collectionUser
                                    .doc(loggedInUser.email.toString())
                                    .update({
                                  't4': '+',
                                });
                                setState(() {
                                  if (t4 == "-") tasks_done++;
                                  t4 = "+";
                                  checkColors();
                                  checkState();
                                  /*if (color4 == Colors.grey) {
                                    tasks_done += 1;
                                    color4 = Colors.orange;
                                    text_color4 = Colors.grey.shade400;
                                  } else if (color4 == Colors.orange) {
                                    tasks_done -= 1;
                                    color4 = Colors.grey;
                                    text_color4 = Colors.grey.shade900;
                                  }*/
                                });
                              },
                              child: Text(
                                task4,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: text_color4,
                                ),
                              ))
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
