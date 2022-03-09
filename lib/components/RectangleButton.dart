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
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontFamily: "Poppins",
              fontSize: 17.0,
            ),
          ),
        ),
      ),
    );
  }
}
