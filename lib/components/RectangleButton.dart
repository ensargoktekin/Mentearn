import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  RoundedRectangleButton(
      {required this.title,
      required this.color,
      required this.textColor,
      required this.onPressed});

  final Color color;
  final Color textColor;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.005),
      child: Material(
        elevation: 8.0,
        color: color,
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Image.asset("images/google_icon.png")
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontFamily: "Poppins",
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
