import 'package:flutter/material.dart';
import 'package:mentearn/screens/welcome_screen.dart';

class GetStarted3 extends StatefulWidget {
  static const String id = 'get_started3';

  @override
  _GetStarted3State createState() => _GetStarted3State();
}

class _GetStarted3State extends State<GetStarted3> {
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
                child: Image.asset("images/Photo_getstarted_4.png")),
            SizedBox(
              height: size.height * 0.025,
            ),
            Center(
              child: SizedBox(
                width: size.width * 0.8,
                child: Text(
                  "Do your tasks and get tree planted!",
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
              "3/3",
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
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                  child: Image.asset("images/Getstarted_button.png")),
            )
          ],
        ),
      ),
    );
  }
}
