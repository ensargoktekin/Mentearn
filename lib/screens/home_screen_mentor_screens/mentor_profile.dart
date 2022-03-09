import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');
final CollectionReference collectionUser2 =
    FirebaseFirestore.instance.collection('mentees');

class MentorProfile extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MentorProfile> {
  final _auth = FirebaseAuth.instance;
  //late Map<String, dynamic> allMentorData;
  var _menteeName = "";
  var _menteeSchool = "";
  var _menteeBio = "";
  var _menteeInterests = "";
  var _mentee = "";

  var _mentorName = "";
  var _mentorSchool = "";
  var _mentorBio = "";
  var _mentorInterests = "";

  Future<void> menteeInfos() async {
    var collection = collectionUser2;
    var docSnapshot = await collection.doc(_mentee).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
        _menteeName = data?['fullname']; // <-- The value you want to retrieve.
        _menteeSchool = data?['school'];
        _menteeBio = data?['bio'];
        _menteeInterests = data?['interests'];
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
      setState(() {
        _mentorName = data?['fullname']; // <-- The value you want to retrieve.
        _mentorSchool = data?['profession'];
        _mentorBio = data?['bio'];
        _mentorInterests = data?['interests'];
        _mentee = data?['mentee'];
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

  /*Future<Map<String, dynamic>> getAllMenteeData() async {
    var collection = collectionUser2;
    var docSnapshot = await collection.doc(loggedInUser.email).get();
    if (docSnapshot.exists) {
      /*allMenteeData =*/return docSnapshot.data() as Map<String, dynamic>;
      //print(allMenteeData['mentor']);
      //print(data);
      //all_data = allda?['requested_mentor']; // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  Future<void> getAllMentorData() async {
    var collection = collectionUser;
    var docSnapshot = await collection.doc(allMenteeData['mentor']).get();
    if (docSnapshot.exists) {
      allMentorData = docSnapshot.data() as Map<String, dynamic>;
      print("inmentor");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              'Your Profile',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 10),
                  child: GestureDetector(
                      onTap: () {
                        print("clicked");
                        setState(() {
                          menteeInfos();
                          print(_mentee);
                          Future.delayed(const Duration(seconds: 1), () {
                            mentorInfos();
                            print('delayed execution');
                          });
                        });
                      },
                      child: ClipRRect(
                        child: Text('Edit Profile'),
                      )),
                )
              ],
            ),
            Text(
              "WelcomeBack,\n$_mentorName",
              style: TextStyle(
                height: 1,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: CircleAvatar(
                        radius: 50,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        width: 120,
                        height: 30,
                        child: Text("Interests",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins")),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        width: 120,
                        height: 30,
                        color: Colors.green,
                        child: Text(
                          _mentorInterests,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _mentorName,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _mentorSchool,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      _mentorBio,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 10, bottom: 0),
                      child: Text(
                        "My Mentee",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                          ),
                          Text(
                            _menteeName,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _menteeSchool,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            _menteeBio,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Stage 1",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                  color: Colors.green.shade900,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "SAPLING",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
