import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');

class AddTasks extends StatefulWidget {
  static const String id = 'addTasks';

  @override
  _AddTasksState createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  final _auth = FirebaseAuth.instance;
  String task1 = "";
  String task2 = "";
  String task3 = "";
  String task4 = "";
  int stage = 0;

  Future<void> mentorInfos() async {
    var collection = collectionUser;
    var docSnapshot = await collection.doc(loggedInUser.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
        stage = data?['stage'];
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
      mentorInfos();
      print('delayed execution');
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "images/WH_MENTOR.png",
            fit: BoxFit.cover,
            width: double.maxFinite,
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.09),
              child: Center(
                  child: Text(
                "Current stage: $stage\nAdd new tasks for the next stage",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: size.height * 0.1,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.orange,
              ),
              child: TextField(
                onChanged: (value) {
                  task1 = value;
                },
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: size.height * 0.1,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.orange,
              ),
              child: TextField(
                onChanged: (value) {
                  task2 = value;
                },
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: size.height * 0.1,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.orange,
              ),
              child: TextField(
                onChanged: (value) {
                  task3 = value;
                },
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: size.height * 0.1,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.orange,
              ),
              child: TextField(
                onChanged: (value) {
                  task4 = value;
                },
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: () async {
                await collectionUser.doc(loggedInUser.email.toString()).update({
                  'task1': task1,
                  'task2': task2,
                  'task3': task3,
                  'task4': task4,
                  't1': '-',
                  't2': '-',
                  't3': '-',
                  't4': '-',
                  'stage': stage + 1,
                });
                Navigator.pop(context);
              },
              child: ClipRRect(
                child: Icon(
                  IconData(0xf03cf, fontFamily: 'MaterialIcons'),
                  size: 50.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
