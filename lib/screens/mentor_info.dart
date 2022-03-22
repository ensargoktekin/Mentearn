import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'mentor_cover_letter_screen.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
//import 'whitescreen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');

class MentorInfo extends StatefulWidget {
  static const String id = 'mentorInfo';

  @override
  State<MentorInfo> createState() => _MentorInfoState();
}

class _MentorInfoState extends State<MentorInfo> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  late String fullname;
  late String profession;
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

  File? _photo;

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
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.08),
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
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width*0.125,
                      child: _photo != null
                          ? Image.file(
                              _photo!,
                              width: MediaQuery.of(context).size.width*0.25,
                              height: MediaQuery.of(context).size.height*0.15,
                              fit: BoxFit.fitHeight,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: MediaQuery.of(context).size.width*0.25,
                              height: MediaQuery.of(context).size.height*0.15,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          XFile? xFile = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (xFile == null) return;
                          final ppicRef = firebase_storage
                              .FirebaseStorage.instance
                              .ref("/profilePhotos")
                              .child(FirebaseAuth.instance.currentUser!.uid +
                                  ".jpg");
                          await ppicRef.putFile(File(xFile.path));
                        },
                        child: ClipRRect(
                            child: Image.asset(
                          'images/Take_A_pic.png',
                          height: MediaQuery.of(context).size.height*0.022,
                        )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.03,
                      ),
                      GestureDetector(
                        onTap: () async {
                          XFile? xFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (xFile == null) return;
                          final ppicRef = firebase_storage
                              .FirebaseStorage.instance
                              .ref("/profilePhotos")
                              .child(FirebaseAuth.instance.currentUser!.uid +
                                  ".jpg");
                          await ppicRef.putFile(File(xFile.path));
                        },
                        child: ClipRRect(
                            child: Image.asset(
                          'images/Upload_a_pic.png',
                          height: MediaQuery.of(context).size.height*0.02,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.03,
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
                            width: MediaQuery.of(context).size.width*0.3,
                            height: MediaQuery.of(context).size.height*0.035,
                            child: TextField(
                              autocorrect: false,
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
                                      color: Colors.lightBlue, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlue.shade900,
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
                        width: MediaQuery.of(context).size.width*0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profession',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.32,
                            height: MediaQuery.of(context).size.height*0.035,
                            child: TextField(
                              autocorrect: false,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                profession = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Your Profession',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 5.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlue, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlue.shade900,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025),
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
                              height: MediaQuery.of(context).size.height*0.035,
                              width: MediaQuery.of(context).size.width*0.3,
                              child: TextField(
                                autocorrect: false,
                                controller: textControllerDate,
                                textCapitalization:
                                    TextCapitalization.characters,
                                onTap: () => _selectDate(context),
                                readOnly: true,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                /*textAlign: TextAlign.start,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  birthdate = value;
                                },*/
                                decoration: InputDecoration(
                                  hintText: 'DD.MM.YYYY',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 5.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlue, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlue.shade900,
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
                          width: MediaQuery.of(context).size.width*0.04,
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
                              width: MediaQuery.of(context).size.width*0.33,
                              height: MediaQuery.of(context).size.height*0.035,
                              child: TextField(
                                autocorrect: false,
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
                                        color: Colors.lightBlue, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlue.shade900,
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
                    height: MediaQuery.of(context).size.height*0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025),
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
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.2,
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
                                BorderSide(color: Colors.lightBlue, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlue.shade900, width: 1.0),
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
                              'profession': profession,
                              'birthdate': birthdate,
                              'interests': interests,
                              'bio': bio,
                              'mentee': ''
                            });
                            Navigator.pushNamed(context, MentorCover.id);
                          },
                          child: ClipRRect(
                            child: Icon(
                              IconData(0xf03cf, fontFamily: 'MaterialIcons'),
                              size: 50.0,
                              color: Colors.lightBlue,
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
            image: AssetImage('images/mentor_side.png'),
          ))
        ]),
      ),
    );
  }
}
