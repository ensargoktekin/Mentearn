import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentearn/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final CollectionReference collectionUser =
    FirebaseFirestore.instance.collection('mentors');
final CollectionReference collectionUser2 =
    FirebaseFirestore.instance.collection('mentees');

var _menteeEmail = "";
var _mentorEmail = "";
var _mentorName = "";
var _menteeName = "";
var _mentor = "";

class ChatScreenMentee extends StatefulWidget {
  //static const String id = 'chat_screen';

  @override
  _ChatScreenMenteeState createState() => _ChatScreenMenteeState();
}

class _ChatScreenMenteeState extends State<ChatScreenMentee> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;

  Future<void> menteeInfos() async {
    var collection = collectionUser2;
    var docSnapshot = await collection.doc(loggedInUser.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
        // <-- The value you want to retrieve.
        _mentor = data?['mentor'];
        _menteeName = data?['fullname'];
        _menteeEmail = data?['email'];
      });

      // Call setState if needed.
    }
  }

  Future<void> mentorInfos() async {
    var collection = collectionUser;
    var docSnapshot = await collection.doc(_mentor).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      //print(data);
      setState(() {
        _mentorName = data?['fullname'];
        _mentorEmail = data?['email'];
      });

      print(_mentorName);
      // Call setState if needed.
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    Future.delayed(const Duration(milliseconds: 500), () {
      menteeInfos();
      print('delayed execution1');
      Future.delayed(const Duration(milliseconds: 500), () {
        mentorInfos();
        print('delayed execution2');
      });
    });

    print(_mentor);
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

  /*void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }*/

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
        title: Center(
          child: Text(
            'Your Mentor: $_mentorName',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore
                          .collection('chat$_mentorEmail$_menteeEmail')
                          .add({
                        'timestamp': Timestamp.now(),
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('chat$_mentorEmail$_menteeEmail').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        List<MessageBox> messageBoxes = [];
        final messages = snapshot.data!.docs; // as Iterable;
        messages.sort((a, b) {
          return b["timestamp"].compareTo(a["timestamp"]);
        });

        for (var message in messages as Iterable) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];

          final currentUser = loggedInUser.email;

          final messageBox = MessageBox(
            sender: currentUser == messageSender ? _menteeName : _mentorName,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageBoxes.add(messageBox);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBoxes,
          ),
        );
      },
    );
  }
}

class MessageBox extends StatelessWidget {
  MessageBox({required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 14.0, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
            color: isMe ? Colors.teal.shade800 : Colors.teal,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
