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
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05, top: MediaQuery.of(context).size.height*0.01),
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
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height*0.06,
                              width: MediaQuery.of(context).size.width*0.33,
                              child: Image.asset("images/edit2.png"),
                            ),
                          )
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06),
                  child: Text(
                    "Welcome Back,\n$_mentorName",
                    style: TextStyle(
                      height: MediaQuery.of(context).size.height*0.0011,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width*0.13,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.005,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            height: MediaQuery.of(context).size.height*0.04,
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
                            width: MediaQuery.of(context).size.width*0.3,
                            height: MediaQuery.of(context).size.height*0.04,
                            color: Colors.orange,
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
                      width: MediaQuery.of(context).size.width*0.06,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.0025),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Text(
                              _mentorName,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Text(
                              _mentorSchool,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Text(
                              _mentorBio,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.08),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width*0.125)),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12,vertical: MediaQuery.of(context).size.height*0.02),
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
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
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
                                width: MediaQuery.of(context).size.width*0.5,
                                height: MediaQuery.of(context).size.height*0.05,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.green.shade900,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
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
                                height: MediaQuery.of(context).size.height*0.02,
                              )
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
