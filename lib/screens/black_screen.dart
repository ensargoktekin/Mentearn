import 'package:flutter/material.dart';

class BlackScreen extends StatefulWidget {
  static const String id = 'black_screen';

  @override
  _BlackScreenState createState() => _BlackScreenState();
}

class _BlackScreenState extends State<BlackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //messagesStream();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
