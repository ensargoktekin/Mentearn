import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');
final CollectionReference collectionUser2 =
FirebaseFirestore.instance.collection('mentees');*/

class NoMenteePage extends StatefulWidget {
  @override
  _NoMenteePageState createState() => _NoMenteePageState();
}

class _NoMenteePageState extends State<NoMenteePage> {
  /*final _auth = FirebaseAuth.instance;
  var _mentee = "";

  Future<void> mentorInfos() async {
    var collection = collectionUser;
    var docSnapshot = await collection.doc(loggedInUser.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
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
    Future.delayed(Duration(milliseconds: 1000), () {
      mentorInfos();
      print('delayed execution');
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
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
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),*/
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "You have no mentee yet",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          /*Center(
            child: Text(
              _mentee == "" ? "" : "also, you already\nhave a mentee",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
