import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'whitescreen.dart';
import 'home_screen_mentee.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentees');

class MenteeCover extends StatefulWidget {
  static const String id = 'menteeCover';

  @override
  _MenteeCoverState createState() => _MenteeCoverState();
}

class _MenteeCoverState extends State<MenteeCover> {
  final _auth = FirebaseAuth.instance;
  late String reasonsText;

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          child: Image.asset(
            "images/Why_do_You_want_to_be_a_mentee.png",
            fit: BoxFit.cover,
            width: double.maxFinite,
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.1,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.09),
              child: Center(
                  child: Text(
                "Why Do You Want to Become a Mentee?",
                style: TextStyle(
                    fontSize: 31,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.06,
            ),
            Container(
              height: size.height * 0.3,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFF83C082),
              ),
              child: TextField(
                onChanged: (value) {
                  reasonsText = value;
                },
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.03,
            ),
            GestureDetector(
              onTap: () async {
                await collectionUser.doc(loggedInUser.email.toString()).update({
                  'reasonsText': reasonsText,
                });
                Navigator.pushNamed(context, HomeScreenMentee.id);
              },
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.55),
                  ClipRRect(
                    child: Icon(
                      IconData(0xf03cf, fontFamily: 'MaterialIcons'),
                      size: 50.0,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
