import 'package:flutter/material.dart';
import 'package:mentearn/screens/home_screen_mentie_screens/mentee_profile.dart';
import 'welcome_screen.dart';
import 'home_screen_mentie_screens/discover.dart';
import 'home_screen_mentie_screens/chat_mentie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen_mentie_screens/home_mentee.dart';
import 'package:mentearn/screens/google_meet_screens/dashboard_screen.dart';
import 'package:mentearn/screens/home_screen_mentie_screens/already_have_mentor.dart';
import 'package:mentearn/screens/home_screen_mentie_screens/not_have_mentor.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser2 =
    FirebaseFirestore.instance.collection('mentees');

class HomeScreenMentee extends StatefulWidget {
  static const String id = 'homeScreenMentee';

  @override
  _HomeScreenMenteeState createState() => _HomeScreenMenteeState();
}

class _HomeScreenMenteeState extends State<HomeScreenMentee> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  final _auth = FirebaseAuth.instance;
  var _mentor = "";

  Future<void> menteeInfos() async {
    var collection = collectionUser2;
    var docSnapshot = await collection.doc(loggedInUser.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
        // <-- The value you want to retrieve.
        _mentor = data?['mentor'];
      });

      // Call setState if needed.
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    Future.delayed(const Duration(milliseconds: 500), () {
      menteeInfos();
      print('delayed execution2');
    });
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
      menteeInfos();
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
          //Container(color: Colors.greenAccent),
          _mentor == "" ? NotHave() : HomeMentee(),
          _mentor == "" ? Interests() : AlreadyHave(),
          ChatScreenMentee(),
          MenteeProfile(),
          DashboardScreen(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.107,
        child: BottomNavigationBar(
          //fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Discover',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call_rounded),
                label: 'Google Meet',
                backgroundColor: Colors.green),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.green[50],
          onTap: onTapped,
        ),
      ),
    );
  }
}
