import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentearn/screens/home_screen_mentie_screens/apply.dart';
import 'package:mentearn/screens/whitescreen.dart';

final _firestore = FirebaseFirestore.instance;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');
final CollectionReference collectionUser2 =
    FirebaseFirestore.instance.collection('mentees');
late User loggedInUser;

class DiscoverStream extends StatefulWidget {
  @override
  State<DiscoverStream> createState() => _DiscoverStreamState();
}

class _DiscoverStreamState extends State<DiscoverStream> {
  final _auth = FirebaseAuth.instance;
  late String department;
  late String email;
  late String fullname;
  late String position;
  late String bio;

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
      appBar: AppBar(
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
        backgroundColor: Colors.green,
        title: Center(
          child: Text(
            'Discover Mentors',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      /*AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text(
            'Discover Mentors',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),*/
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('mentors').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      );
                    }
                    List<Discover> mentorBoxes = [];
                    final mentors = snapshot.data!.docs; // as Iterable;
                    /*mentors.sort((b, a) {
                      return b["timestamp"].compareTo(a["timestamp"]);
                    });*/

                    for (var mentor in mentors as Iterable) {
                      department = mentor.data()['profession'];
                      email = mentor.data()['email'];
                      fullname = mentor.data()['fullname'];
                      position = mentor.data()['profession'];
                      bio = mentor.data()['bio'];
                      /*final messageText = mentor.data()['text'];
                  final messageSender = mentor.data()['sender'];*/

                      final mentorBox = Discover(
                        department: department,
                        email: email,
                        fullname: fullname,
                        position: position,
                        bio: bio,
                      );
                      mentorBoxes.add(mentorBox);
                    }
                    //print(mentorBoxes.length);
                    return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //reverse: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: mentorBoxes,
                    );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}

class Discover extends StatefulWidget {
  final String department;
  final String fullname;
  final String position;
  final String bio;
  final String email;
  Discover(
      {required this.department,
      required this.fullname,
      required this.position,
      required this.bio,
      required this.email});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return /*Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Text(
            department,
            style: TextStyle(fontSize: 14.0, color: Colors.black54),
          ),
          Text(
            fullname,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );*/
        Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: Colors.grey)),
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Center(
                      child: Text(
                    widget.department,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6)),
                      color: Colors.green),
                  height: MediaQuery.of(context).size.height * (0.05),
                  width: MediaQuery.of(context).size.width * (0.25),
                  alignment: Alignment.bottomRight,
                ),
              ],
            ),
            /*CircleAvatar(
              radius: 30,
            ),*/
            SizedBox(
              height: 5,
            ),
            Text(
              widget.fullname,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 3,
            ),
            Text(widget.position,
                style: TextStyle(fontSize: 15, color: Color(0xFF585C60))),
            SizedBox(
              height: 2,
            ),
            Text(widget.bio,
                style: TextStyle(fontSize: 15, color: Color(0xFF585C60))),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 25,
                child: OutlinedButton(
                  child: Text(
                    '         Apply         ',
                    style: TextStyle(color: Color(0xFF66a865)),
                  ),
                  style: OutlinedButton.styleFrom(
                    onSurface: Color(0xFF497a48),
                    primary: Color(0xFF497a48),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Color(0xFF66a865), width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () async {
                    await collectionUser2
                        .doc(loggedInUser.email.toString())
                        .update(
                            {"requested_mentor": widget.email, "mentor": ""});
                    Navigator.pushNamed(context, Apply.id);
                  },
                ) /*OutlinedButton(,
                child: Text("Outline Button", style: TextStyle(fontSize: 10.0),),
                highlightedBorderColor: Colors.red,
                disabledTextColor: Colors.red,
                color: Colors.red,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                highlightColor: Colors.red,
                hoverColor: Colors.red,
                disabledBorderColor: Colors.red,
                focusColor: Colors.red,
                splashColor: Colors.red,
                onPressed: () {},
              ),*/
                ),
          ],
        ),
      ),
    );
  }
}
