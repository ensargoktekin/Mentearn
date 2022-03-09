import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:mentearn/screens/whitescreen.dart';
import 'package:mentearn/screens/black_screen.dart';
import 'package:mentearn/screens/welcome_screen.dart';
import 'package:mentearn/screens/registration_screen_for_mentor.dart';
import 'package:mentearn/screens/registration_screen_for_mentee.dart';
import 'package:mentearn/screens/login_screen_mentee.dart';
import 'package:mentearn/screens/login_screen_mentor.dart';
import 'package:mentearn/screens/mentee_cover_letter_screen.dart';
import 'package:mentearn/screens/mentor_cover_letter_screen.dart';
import 'package:mentearn/screens/home_screen_mentee.dart';
import 'package:mentearn/screens/mentee_info.dart';
import 'package:mentearn/screens/mentor_info.dart';
import 'package:mentearn/screens/home_screen_mentie_screens/apply.dart';
import 'package:mentearn/screens/home_screen_mentor.dart';
import 'package:mentearn/google_meet/calendar_client.dart';
import 'package:mentearn/google_meet/secrets.dart';
import 'package:mentearn/screens/google_meet_screens/create_screen.dart';
import 'package:mentearn/screens/google_meet_screens/edit_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var _clientID = new ClientId(Secret.getId(), "");
  const _scopes = [cal.CalendarApi.calendarScope];
  await clientViaUserConsent(_clientID, _scopes, prompt)
      .then((AuthClient client) async {
    CalendarClient.calendar = cal.CalendarApi(client);
  });

  runApp(Mentearn());
}

void prompt(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Mentearn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreenMentor.id: (context) => RegistrationScreenMentor(),
        RegistrationScreenMentee.id: (context) => RegistrationScreenMentee(),
        LoginScreenMentee.id: (context) => LoginScreenMentee(),
        LoginScreenMentor.id: (context) => LoginScreenMentor(),
        WhiteScreen.id: (context) => WhiteScreen(),
        BlackScreen.id: (context) => BlackScreen(),
        MenteeCover.id: (context) => MenteeCover(),
        MentorCover.id: (context) => MentorCover(),
        HomeScreenMentee.id: (context) => HomeScreenMentee(),
        HomeScreenMentor.id: (context) => HomeScreenMentor(),
        MenteeInfo.id: (context) => MenteeInfo(),
        MentorInfo.id: (context) => MentorInfo(),
        Apply.id: (context) => Apply(),
        CreateScreen.id: (context) => CreateScreen(),
        //EditScreen.id: (context) => EditScreen(event: context,),

        //ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
