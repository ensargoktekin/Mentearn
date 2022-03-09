import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'whitescreen.dart';
import 'home_screen_mentor.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');

class MentorCover extends StatefulWidget {
  static const String id = 'mentorCover';

  @override
  _MentorCoverState createState() => _MentorCoverState();
}

class _MentorCoverState extends State<MentorCover> {
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
              height: 70,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 34),
              child: Center(
                  child: Text(
                "Why Do You Want to Become a Mentor?",
                style: TextStyle(
                    fontSize: 31,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: size.height * 0.3,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.orange,
              ),
              child: TextField(
                onChanged: (value) {
                  reasonsText = value;
                },
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              padding: EdgeInsets.all(15),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                await collectionUser.doc(loggedInUser.email.toString()).update({
                  'reasonsText': reasonsText,
                });
                Navigator.pushNamed(context, HomeScreenMentor.id);
              },
              child: ClipRRect(
                child: Icon(
                  IconData(0xf03cf, fontFamily: 'MaterialIcons'),
                  size: 50.0,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
