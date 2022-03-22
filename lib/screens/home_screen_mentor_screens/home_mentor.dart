import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class HomeMentor extends StatefulWidget {
  @override
  _HomeMentorState createState() => _HomeMentorState();
}

int tasks_done = 0;
int total_tasks = 4;
IconData icon1 = Icons.check_circle_outline_rounded;
IconData icon2 = Icons.check_circle_outline_rounded;
IconData icon3 = Icons.check_circle_outline_rounded;
IconData icon4 = Icons.check_circle_outline_rounded;

Color color1 = Colors.grey;
Color color2 = Colors.grey;
Color color3 = Colors.grey;
Color color4 = Colors.grey;

Color text_color1 = Colors.grey.shade900;
Color text_color2 = Colors.grey.shade900;
Color text_color3 = Colors.grey.shade900;
Color text_color4 = Colors.grey.shade900;

class _HomeMentorState extends State<HomeMentor> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("images/mentor_blob.png"),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(

                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.12, left: MediaQuery.of(context).size.width*0.12),
                    child: Text(
                      "My\nTasks",
                      style: TextStyle(
                        height: MediaQuery.of(context).size.height*0.0011,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.12, top: MediaQuery.of(context).size.height*0.08,right: MediaQuery.of(context).size.width*0.07),
                      child: ClipRRect(
                        child: Image.asset("images/add_task.png"),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.13, top: MediaQuery.of(context).size.height*0.17),
                        child: LiquidCustomProgressIndicator(
                          value: tasks_done / total_tasks,
                          valueColor: AlwaysStoppedAnimation(Colors.orange),
                          backgroundColor: Colors.blue[100],
                          direction: Axis.vertical,
                          shapePath: _buildBoatPath(),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width*0.145, height: MediaQuery.of(context).size.height*0.01),
                          Image.asset("images/tree.png"),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.11,
                          ),
                          Text(
                            "STAGE 1",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.13,
                            height: MediaQuery.of(context).size.height*0.04,
                            child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    if (color1 == Colors.grey) {
                                      tasks_done += 1;
                                      color1 = Colors.orange;
                                      text_color1 = Colors.grey.shade400;
                                    } else if (color1 == Colors.orange) {
                                      tasks_done -= 1;
                                      color1 = Colors.grey;
                                      text_color1 = Colors.grey.shade900;
                                    }
                                  });
                                },
                                child: Icon(
                                  icon1,
                                  color: color1,
                                  size: 30,
                                )),
                          ),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  if (color1 == Colors.grey) {
                                    tasks_done += 1;
                                    color1 = Colors.orange;
                                    text_color1 = Colors.grey.shade400;
                                  } else if (color1 == Colors.orange) {
                                    tasks_done -= 1;
                                    color1 = Colors.grey;
                                    text_color1 = Colors.grey.shade900;
                                  }
                                });
                              },
                              child: Text(
                                "Have a first meeting",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: text_color1,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.13,
                            height: MediaQuery.of(context).size.height*0.04,
                            child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    if (color2 == Colors.grey) {
                                      tasks_done += 1;
                                      color2 = Colors.orange;
                                      text_color2 = Colors.grey.shade400;
                                    } else if (color2 == Colors.orange) {
                                      tasks_done -= 1;
                                      color2 = Colors.grey;
                                      text_color2 = Colors.grey.shade900;
                                    }
                                  });
                                },
                                child: Icon(
                                  icon2,
                                  color: color2,
                                  size: 30,
                                )),
                          ),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  if (color2 == Colors.grey) {
                                    tasks_done += 1;
                                    color2 = Colors.orange;
                                    text_color2 = Colors.grey.shade400;
                                  } else if (color2 == Colors.orange) {
                                    tasks_done -= 1;
                                    color2 = Colors.grey;
                                    text_color2 = Colors.grey.shade900;
                                  }
                                });
                              },
                              child: Text(
                                "Take a selfie",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: text_color2,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.13,
                            height: MediaQuery.of(context).size.height*0.04,
                            child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    if (color3 == Colors.grey) {
                                      tasks_done += 1;
                                      color3 = Colors.orange;
                                      text_color3 = Colors.grey.shade400;
                                    } else if (color3 == Colors.orange) {
                                      tasks_done -= 1;
                                      color3 = Colors.grey;
                                      text_color3 = Colors.grey.shade900;
                                    }
                                  });
                                },
                                child: Icon(
                                  icon3,
                                  color: color3,
                                  size: 30,
                                )),
                          ),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  if (color3 == Colors.grey) {
                                    tasks_done += 1;
                                    color3 = Colors.orange;
                                    text_color3 = Colors.grey.shade400;
                                  } else if (color3 == Colors.orange) {
                                    tasks_done -= 1;
                                    color3 = Colors.grey;
                                    text_color3 = Colors.grey.shade900;
                                  }
                                });
                              },
                              child: Text(
                                "Study 3 days in a row",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: text_color3,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.13,
                            height: MediaQuery.of(context).size.height*0.04,
                            child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    if (color4 == Colors.grey) {
                                      tasks_done += 1;
                                      color4 = Colors.orange;
                                      text_color4 = Colors.grey.shade400;
                                    } else if (color4 == Colors.orange) {
                                      tasks_done -= 1;
                                      color4 = Colors.grey;
                                      text_color4 = Colors.grey.shade900;
                                    }
                                  });
                                },
                                child: Icon(
                                  icon4,
                                  color: color4,
                                  size: 30,
                                )),
                          ),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  if (color4 == Colors.grey) {
                                    tasks_done += 1;
                                    color4 = Colors.orange;
                                    text_color4 = Colors.grey.shade400;
                                  } else if (color4 == Colors.orange) {
                                    tasks_done -= 1;
                                    color4 = Colors.grey;
                                    text_color4 = Colors.grey.shade900;
                                  }
                                });
                              },
                              child: Text(
                                "Study 10 days in a row",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: text_color4,
                                ),
                              ))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Path _buildBoatPath() {
    return Path()
      ..lineTo(0, 130)
      ..lineTo(40, 130)
      ..lineTo(40, 0)
      ..close();
  }
}
