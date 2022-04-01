import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/screens/patientScreens/nav%20bar/custom_bottom_nav_bar.dart';
import 'package:flutter_medimind_app/screens/patientScreens/patient_home_screen.dart';
import 'package:flutter_medimind_app/screens/patientScreens/profile_screen.dart';
import 'package:flutter_medimind_app/screens/patientScreens/report_screen.dart';
import 'package:flutter_medimind_app/screens/patientScreens/upcoming_screen.dart';
import 'package:flutter_medimind_app/services/anonymous_auth_service.dart';
import 'package:provider/provider.dart';

class BottomNavHandler extends StatefulWidget {
  const BottomNavHandler({Key? key}) : super(key: key);

  @override
  _BottomNavHandlerState createState() => _BottomNavHandlerState();
}

class _BottomNavHandlerState extends State<BottomNavHandler> {
  List<Widget> _screenList = const [
    PatientHomeScreen(),
    UpcomingScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        // color: cadetBlue,
        buttonBackgroundColor: whiteColor,
        backgroundColor: Colors.black12,
        height: 70,
        items: [
          [
            Container(
              margin: EdgeInsets.only(bottom: 3),
              child: Icon(Icons.home_filled),
            ),
            Text('Home'),
          ],
          [
            Container(
              margin: EdgeInsets.only(bottom: 3),
              child: Icon(Icons.calendar_today_outlined),
            ),
            Text('Calender'),
          ],
          [
            Container(
              margin: EdgeInsets.only(bottom: 3),
              child: Icon(Icons.analytics_outlined),
            ),
            Text('Report'),
          ],
          [
            Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.person_pin)),
            Text('Profile'),
          ]
        ],
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
      ),
      body: _screenList.elementAt(_selectedIndex),
    );
  }
}
