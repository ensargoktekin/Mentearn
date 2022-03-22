import 'package:flutter/material.dart';
import 'package:mentearn/screens/home_screen_mentie_screens/mentee_profile.dart';
import 'package:mentearn/screens/home_screen_mentor_screens/chat_mentor.dart';
import 'welcome_screen.dart';
import 'home_screen_mentie_screens/discover.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen_mentor_screens/mentor_profile.dart';
import 'home_screen_mentor_screens/home_mentor.dart';
import 'home_screen_mentor_screens/request.dart';
import 'package:mentearn/screens/google_meet_screens/dashboard_screen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');

class HomeScreenMentor extends StatefulWidget {
  static const String id = 'homeScreenMentor';

  @override
  _HomeScreenMentorState createState() => _HomeScreenMentorState();
}

class _HomeScreenMentorState extends State<HomeScreenMentor> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  final _auth = FirebaseAuth.instance;

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

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('mentearn')),
      body: PageView(
        controller: pageController,
        children: [
          //Container(color: Colors.green),
          HomeMentor(),
          RequestPage(),
          ChatScreenMentor(),
          MentorProfile(),
          DashboardScreen(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height*0.107,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.orange),
            BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Request', backgroundColor: Colors.orange),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat', backgroundColor: Colors.orange),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile', backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call_rounded), label: 'Google Meet', backgroundColor: Colors.orange),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.orange[50],
          onTap: onTapped,
        ),
      ),
    );
  }
}
