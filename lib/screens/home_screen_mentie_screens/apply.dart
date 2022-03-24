import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentearn/screens/whitescreen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');
final CollectionReference collectionUser2 =
    FirebaseFirestore.instance.collection('mentees');

class Apply extends StatefulWidget {
  static const String id = 'apply';

  @override
  _ApplyState createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
  final _auth = FirebaseAuth.instance;
  late String textField;
  var mentor;

  Future<void> getMentor() async {
    var collection = collectionUser2;
    var docSnapshot = await collection.doc(loggedInUser.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      mentor = data?['requested_mentor']; // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
        resizeToAvoidBottomInset: false,
        body: Stack(
      children: [
        Container(
          child: Image.asset(
            "images/Why do you wanna mentee.png",
            fit: BoxFit.cover,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Center(
              child: Container(
                child: TextField(
                  autocorrect: false,
                  onChanged: (value) {
                    textField = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.09),
                //decoration: BoxDecoration(
                    //border: Border.all(color: Color(0xFF66a865), width: 2)),
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.009,
            ),
            Container(
                height: MediaQuery.of(context).size.height*0.025,
                padding: EdgeInsets.only(bottom: 5),
                child: OutlinedButton(
                  child: Text(
                    '     Send     ',
                    style: TextStyle(color: Color(0xFF66a865)),
                  ),
                  style: OutlinedButton.styleFrom(
                    onSurface: Color(0xFF497a48),
                    primary: Color(0xFF497a48),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.green, width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () async {
                    await getMentor();
                    await collectionUser
                        .doc(
                            /*'tuna1@gmail.com' loggedInUser.email.toString()*/ mentor)
                        .update({
                      "request": loggedInUser.email,
                      "mentee": "", //loggedInUser.email,
                      "coverLetter": textField
                    });
                    Navigator.pop(context);
                  },
                ))
          ],
        )
      ],
    ));
  }
}
