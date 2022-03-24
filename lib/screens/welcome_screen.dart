import 'package:flutter/material.dart';
import 'package:mentearn/screens/registration_screen_for_mentor.dart';
import 'registration_screen_for_mentor.dart';
import 'registration_screen_for_mentee.dart';
import 'login_screen_mentee.dart';
import 'login_screen_mentor.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //constant Images:
  Image MENTEE_NORMAL = Image.asset('images/Mentee_Unhovered.png');
  Image MENTEE_HOVERED = Image.asset('images/Mentee_Hovered_SignUp.png');
  Image MENTOR_NORMAL = Image.asset('images/Mentor_unhovered.png');
  Image MENTOR_HOVERED = Image.asset('images/Mentor_Hovered_SignUp.png');

  //bools to check if clicked:
  bool mentorHover = false;
  bool menteeHover = false;

  //current images:
  late Image menteeImage = MENTEE_NORMAL;
  late Image mentorImage = MENTOR_NORMAL;

  //change image when clicking:
  void changeImage(String image) {
    if (image == "mentee") {
      if (menteeHover) {
        //go to sign up page for mentee
        Navigator.pushNamed(context, RegistrationScreenMentee.id);
      } else if (mentorHover) {
        mentorHover = false;
        mentorImage = MENTOR_NORMAL;
        menteeHover = true;
        menteeImage = MENTEE_HOVERED;
        //print("1");
      } else {
        menteeHover = true;
        menteeImage = MENTEE_HOVERED;
      }
    } else if (image == "mentor") {
      if (mentorHover) {
        //go to sign up page for mentor
        Navigator.pushNamed(context, RegistrationScreenMentor.id);
      } else if (menteeHover) {
        mentorHover = true;
        mentorImage = MENTOR_HOVERED;
        menteeHover = false;
        menteeImage = MENTEE_NORMAL;
      } else {
        mentorHover = true;
        mentorImage = MENTOR_HOVERED;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "I want to be...",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 45.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        changeImage("mentee");
                      });
                    },
                    child: ClipRRect(child: menteeImage)),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        changeImage("mentor");
                      });
                    },
                    child: ClipRRect(child: mentorImage)),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            "Already a member? ",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreenMentor.id);
            },
            child: Text(
              "Sign in as a mentor",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreenMentee.id);
            },
            child: Text(
              "Sign in as a mentee",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15.0,
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
