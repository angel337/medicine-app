import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/OTP_verification_screen.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/caretaker_invitation_screen.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/caretaker_profile_screen.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/caretaker_sign_in.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/verification_screen.dart';
import 'package:flutter_medimind_app/screens/first_landing_screen.dart';
import 'package:flutter_medimind_app/screens/patientScreens/add_medicine_screen.dart';
import 'package:flutter_medimind_app/screens/patientScreens/bottom_nav_handler.dart';
import 'package:flutter_medimind_app/screens/patientScreens/patient_home_screen.dart';
import 'package:flutter_medimind_app/screens/patientScreens/patient_sign_in.dart';
import 'package:flutter_medimind_app/screens/patientScreens/upcoming_screen.dart';
import 'package:flutter_medimind_app/services/anonymous_auth_service.dart';
import 'package:flutter_medimind_app/services/authentication_service.dart';
import 'package:flutter_medimind_app/services/firestore_service.dart';
import 'package:flutter_medimind_app/widgets/todays_medicine.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) =>
      print('firebase successfully initialized.' + value.toString()));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>
            AuthService()),
        ChangeNotifierProvider(
          create: (context) =>
              AnonymousAuthService(),
        ),
        ChangeNotifierProvider(create: (context) =>
            FireStoreService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediMind',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          //from RGB
          primary: orange,
          secondary: Colors.amber,
        ),
        fontFamily: GoogleFonts.lato().fontFamily,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: GoogleFonts.lato(
                  fontSize: 86,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.5),
              headline2: GoogleFonts.lato(
                  fontSize: 53,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5),
              headline3:
                  GoogleFonts.lato(fontSize: 43, fontWeight: FontWeight.w400),
              headline4: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25),
              headline5:
                  GoogleFonts.lato(fontSize: 21, fontWeight: FontWeight.w400),
              headline6: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
              subtitle1: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.15),
              subtitle2: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1),
              bodyText1: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
              bodyText2: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25),
              button: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.25),
              caption: GoogleFonts.lato(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4),
              overline: GoogleFonts.lato(
                  fontSize: 9, fontWeight: FontWeight.w400, letterSpacing: 1.5),
            ),
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  Widget build(BuildContext context) {
    String? thePatientUser = Provider.of<AnonymousAuthService>(context).uid;
    String? theCaretakerUser = Provider.of<AuthService>(context).uid;

//TODO: check for the caretaker user as well.
    if (thePatientUser != null) {
      return BottomNavHandler();
    } else if (theCaretakerUser != null) {
      return caretakerInvitationScreen();
    }
    return FirstLandingScreen();
  }
}
