import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'whitescreen.dart';
import 'mentee_cover_letter_screen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentees');

class MenteeInfo extends StatefulWidget {
  static const String id = 'menteeInfo';

  @override
  State<MenteeInfo> createState() => _MenteeInfoState();
}

class _MenteeInfoState extends State<MenteeInfo> {
  final _auth = FirebaseAuth.instance;
  late String fullname;
  late String school;
  late String birthdate;
  late String interests;
  late String bio;

  DateTime selectedDate = DateTime.now();
  late TextEditingController textControllerDate;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    textControllerDate = TextEditingController();
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textControllerDate.text = DateFormat.yMMMMd().format(selectedDate);
        birthdate = textControllerDate.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
            Widget>[
          Expanded(
            flex: 3,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 75.0),
                    child: Text(
                      'Create Your Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*GestureDetector(
                          onTap: () {
                            setState(() {

                            });
                          },
                          child: ClipRRect(
                              child: Image.asset('images/Take_A_pic.png')),
                        ),
                        SizedBox(
                          width: 10,
                        ),*/
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: ClipRRect(
                            child: Image.asset('images/Upload_a_pic.png')),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            height: 30,
                            child: TextField(
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                fullname = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Your Full Name',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 5.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange.shade900,
                                      width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'School-Department',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(
                            width: 130,
                            height: 30,
                            child: TextField(
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                school = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Your School/Department',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 5.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange.shade900,
                                      width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Birthdate',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: 110,
                                child: TextField(
                                  controller: textControllerDate,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  onTap: () => _selectDate(context),
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'DD.MM.YYYY',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 5.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orange, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orange.shade900,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Interests',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              height: 30,
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  interests = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Your Interests',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 5.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange.shade900,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Bio',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: TextField(
                        autocorrect: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          bio = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Give us information about yourself.',
                          hintMaxLines: 2,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 5.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange.shade900, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                        color: Colors.white,
                      )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await collectionUser
                                .doc(loggedInUser.email.toString())
                                .update({
                              'fullname': fullname,
                              'school': school,
                              'birthdate': birthdate,
                              'interests': interests,
                              'bio': bio
                            });
                            Navigator.pushNamed(context, MenteeCover.id);
                          },
                          child: ClipRRect(
                            child: Icon(
                              IconData(0xf03cf, fontFamily: 'MaterialIcons'),
                              size: 50.0,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Image(
            fit: BoxFit.cover,
            image: AssetImage('images/mentee_side.png'),
          ))
        ]),
      ),
    );
  }
}
