import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentearn/constants.dart';
import 'package:mentearn/components/RectangleButton.dart';
import 'package:mentearn/screens/home_screen_mentor.dart';

class LoginScreenMentor extends StatefulWidget {
  static const String id = 'login_screen_mentor';

  @override
  _LoginScreenMentorState createState() => _LoginScreenMentorState();
}

class _LoginScreenMentorState extends State<LoginScreenMentor> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  late final User _user;
  String email = '';
  String password = '';

  /*Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }*/

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("User is not found, please try again"),
            ));
  }

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
          "Mentor Login Page",
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
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, HomeScreenMentor.id);
                    }
                  } catch (e) {
                    Future.delayed(Duration.zero, () => showAlert(context));
                    //Navigator.pushNamed(context, BlackScreen.id);
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
                  Navigator.pushNamed(context, HomeScreenMentor.id);
                },
              ),
            ),
            /*Flexible(
              child: RoundedRectangleButton(
                title: 'Facebook',
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () async {
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
