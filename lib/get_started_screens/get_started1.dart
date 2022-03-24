import 'package:flutter/material.dart';
import 'package:mentearn/get_started_screens/get_started2.dart';

class GetStarted1 extends StatefulWidget {
  static const String id = 'get_started1';

  @override
  _GetStarted1State createState() => _GetStarted1State();
}

class _GetStarted1State extends State<GetStarted1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                width: size.width * 0.6,
                child: Image.asset("images/Photo_getstarted_1.png")),
            SizedBox(
              height: size.height * 0.025,
            ),
            Center(
              child: SizedBox(
                width: size.width * 0.8,
                child: Text(
                  "Find mentors from all around the world!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Text(
              "1/3",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
              ),
            ),
            /*SizedBox(
                  height: size.height*0.05,
                ),*/
            SizedBox(
              width: size.width * 2 / 3,
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, GetStarted2.id);
                  },
                  child: Image.asset("images/Getstarted_button.png")),
            )
          ],
        ),
      ),
    );
  }
}
