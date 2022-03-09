import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentearn/constants.dart';
import 'package:mentearn/components/RectangleButton.dart';
import 'mentor_info.dart';

final _firestore = FirebaseFirestore.instance;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');

class RegistrationScreenMentor extends StatefulWidget {
  static const String id = 'registration_screen_mentor';

  @override
  _RegistrationScreenMentorState createState() =>
      _RegistrationScreenMentorState();
}

class _RegistrationScreenMentorState extends State<RegistrationScreenMentor> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  late final User _user;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.backpack,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Register as a mentor",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              " E-mail",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              " Password",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            Flexible(
              child: GestureDetector(
                onTap: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      DocumentReference<Map<String, dynamic>> users =
                          FirebaseFirestore.instance
                              .collection('mentors')
                              .doc("$email");
                      var myJSONObj = {
                        'timestamp': Timestamp.now(),
                        'email': email,
                        'password': password,
                        'request': "",
                        "mentee": "",
                        "coverLetter": ""
                      };
                      users.set(myJSONObj);
                      print(newUser.user?.email);
                      /*_firestore.collection('mentors').add({
                        'timestamp': Timestamp.now(),
                        'email': email,
                        'password': password,
                        //'mentee_list': List<String>,
                      });*/
                      Navigator.pushNamed(context, MentorInfo.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: ClipRRect(
                  child: Image.asset(
                    'images/Sign_up2.png',
                    height: 40.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: Text(
                "Or sign in with...",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Flexible(
              child: RoundedRectangleButton(
                title: 'Google',
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () async {
                  final GoogleSignInAccount? googleSignInAccount =
                      await _googleSignIn.signIn();
                  final GoogleSignInAuthentication googleSignInAuthentication =
                      await googleSignInAccount!.authentication;
                  final AuthCredential credential =
                      GoogleAuthProvider.credential(
                    accessToken: googleSignInAuthentication.accessToken,
                    idToken: googleSignInAuthentication.idToken,
                  );
                  await _auth.signInWithCredential(credential);
                  _user = await _auth.currentUser!;
                  email = _user.email!;
                  print("email: " + email);
                  //sign in complete
                  DocumentReference<Map<String, dynamic>> users =
                      FirebaseFirestore.instance
                          .collection('mentors')
                          .doc("$email");
                  var myJSONObj = {
                    'timestamp': Timestamp.now(),
                    'email': email,
                    'password': "SIGNED_IN_WITH_GOOGLE",
                    'request': "",
                    "mentee": "",
                    "coverLetter": ""
                  };
                  users.set(myJSONObj);
                  //print(newUser.user?.email);
                  /*_firestore.collection('mentors').add({
                        'timestamp': Timestamp.now(),
                        'email': email,
                        'password': password,
                        //'mentee_list': List<String>,
                      });*/
                  Navigator.pushNamed(context, MentorInfo.id);
                  print(_user.email);
                },
              ),
            ),
            /*Flexible(
              child: RoundedRectangleButton(
                title: 'Facebook',
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.pushNamed(context, MenteeCover.id);
                  /*try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, WhiteScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }*/
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
