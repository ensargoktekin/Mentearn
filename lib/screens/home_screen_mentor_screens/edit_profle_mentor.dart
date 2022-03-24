import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');

class EditProfileMentor extends StatefulWidget {
  static const String id = 'editProfileMentor';

  @override
  State<EditProfileMentor> createState() => _EditProfileMentorState();
}

class _EditProfileMentorState extends State<EditProfileMentor> {
  final _auth = FirebaseAuth.instance;
  late String fullname;
  late String position;
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

  /*_selectDate(BuildContext context) async {
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
  }*/

  File? _photo;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
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
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: Center(
                      child: Text(
                        'Edit Your Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.125,
                      child: _photo != null
                          ? Image.file(
                              _photo!,
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.15,
                              fit: BoxFit.fitHeight,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
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
                          height: MediaQuery.of(context).size.height * 0.022,
                        )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
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
                          height: MediaQuery.of(context).size.height * 0.02,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.035,
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
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Position',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.035,
                            child: TextField(
                              autocorrect: false,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                position = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Your Position',
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.025),
                    child: Row(
                      children: [
                        /*Column(
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
                            ]),*/
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
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
                              width: MediaQuery.of(context).size.width * 0.4,
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
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
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.09),
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
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.09),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.2,
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
                              'profession': position,
                              /*'birthdate': birthdate,*/
                              'interests': interests,
                              'bio': bio
                            });
                            Navigator.pop(context);
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
          /*Expanded(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('images/mentee_side.png'),
              ))*/
        ]),
      ),
    );
  }
}
