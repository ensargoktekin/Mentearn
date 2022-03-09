import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');
final CollectionReference collectionUser2 =
    FirebaseFirestore.instance.collection('mentees');

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _auth = FirebaseAuth.instance;
  var _menteeRequest = "";
  var _coverLetter = "";
  var _menteeName = "";
  var _menteeSchool = "";
  var _menteeBio = "";
  String status = "pending";
  Color statusColor = Colors.black;

  Future<void> menteeInfos() async {
    var collection = collectionUser2;
    var docSnapshot = await collection.doc(_menteeRequest).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
        _menteeName = data?['fullname']; // <-- The value you want to retrieve.
        _menteeSchool = data?['school'];
        _menteeBio = data?['bio'];
        //_menteeInterests = data?['interests'];
        //_mentor = data?['mentor'];
      });

      // Call setState if needed.
    }
  }

  Future<void> mentorInfos() async {
    var collection = collectionUser;
    var docSnapshot = await collection.doc(loggedInUser.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      _coverLetter = data?['coverLetter'];
      _menteeRequest = data?['request'];

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
        menteeInfos();
        print('delayed execution');
      });
    });

    //print(_mentor);

    //menteeInfos();
    /*getAllMenteeData();
    getAllMentorData();*/
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
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //messagesStream();
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        backgroundColor: Colors.orange,
        title: Center(
          child: Text(
            'Mentee Applications',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          /*Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                "Mentee\nApplications",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 30,
          ),*/
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: Colors.orange)),
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 13,
                  ),
                  CircleAvatar(
                    radius: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    _menteeName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(_menteeSchool,
                      style: TextStyle(fontSize: 12, color: Color(0xFF585C60))),
                  SizedBox(
                    height: 2,
                  ),
                  Text(_menteeBio,
                      style: TextStyle(fontSize: 12, color: Color(0xFF585C60))),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Cover letter: $_coverLetter",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: 25,
                          child: OutlinedButton(
                            child: Text(
                              '      Accept      ',
                              style: TextStyle(color: Colors.deepOrangeAccent),
                            ),
                            style: OutlinedButton.styleFrom(
                              onSurface: Color(0xFF497a48),
                              primary: Color(0xFF497a48),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  color: Colors.deepOrangeAccent, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            onPressed: () async {
                              setState(() {
                                statusColor = Colors.green;
                                status = "accepted";
                              });
                              await collectionUser2.doc(_menteeRequest).update({
                                "mentor": "${loggedInUser.email}",
                              });
                              await collectionUser
                                  .doc(loggedInUser.email)
                                  .update({
                                "request": "",
                                "mentee": "$_menteeRequest",
                                "coverLetter": ""
                              });
                            },
                          ) /*OutlinedButton(,
                          child: Text("Outline Button", style: TextStyle(fontSize: 10.0),),
                          highlightedBorderColor: Colors.red,
                          disabledTextColor: Colors.red,
                          color: Colors.red,

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          highlightColor: Colors.red,
                          hoverColor: Colors.red,
                          disabledBorderColor: Colors.red,
                          focusColor: Colors.red,
                          splashColor: Colors.red,
                          onPressed: () {},
                        ),*/
                          ),
                      Container(
                          height: 25,
                          child: OutlinedButton(
                            child: Text('      Reject      ',
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                )),
                            style: OutlinedButton.styleFrom(
                              onSurface: Color(0xFF497a48),
                              primary: Color(0xFF497a48),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  color: Colors.deepOrangeAccent, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            onPressed: () async {
                              setState(() {
                                status = "rejected";
                                statusColor = Colors.red;
                              });
                              await collectionUser
                                  .doc(loggedInUser.email)
                                  .update({
                                "request": "",
                                "mentee": "",
                                "coverLetter": ""
                              });
                            },
                          ) /*OutlinedButton(,
                          child: Text("Outline Button", style: TextStyle(fontSize: 10.0),),
                          highlightedBorderColor: Colors.red,
                          disabledTextColor: Colors.red,
                          color: Colors.red,

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          highlightColor: Colors.red,
                          hoverColor: Colors.red,
                          disabledBorderColor: Colors.red,
                          focusColor: Colors.red,
                          splashColor: Colors.red,
                          onPressed: () {},
                        ),*/
                          ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    status,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: statusColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
