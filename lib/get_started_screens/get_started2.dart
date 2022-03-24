import 'package:flutter/material.dart';
import 'package:mentearn/get_started_screens/get_started3.dart';

class GetStarted2 extends StatefulWidget {
  static const String id = 'get_started2';

  @override
  _GetStarted2State createState() => _GetStarted2State();
}

class _GetStarted2State extends State<GetStarted2> {
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
                child: Image.asset("images/Photo_Getstarted_2.png")),
            SizedBox(
              height: size.height * 0.025,
            ),
            Center(
              child: SizedBox(
                width: size.width * 0.8,
                child: Text(
                  "Send request to mentors with respect to their profession and interests",
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
              "2/3",
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
                    Navigator.pushNamed(context, GetStarted3.id);
                  },
                  child: Image.asset("images/Getstarted_button.png")),
            )
          ],
        ),
      ),
    );
  }
}
