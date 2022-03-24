import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentees');
/*final CollectionReference collectionUser2 =
FirebaseFirestore.instance.collection('mentees');*/

class NotHave extends StatefulWidget {
  @override
  _NotHaveState createState() => _NotHaveState();
}

class _NotHaveState extends State<NotHave> {
  final _auth = FirebaseAuth.instance;
  //var _mentee = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();

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
              "you do not\nhave a mentor",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
