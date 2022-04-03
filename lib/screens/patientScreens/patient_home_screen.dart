import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/screens/patientScreens/add_medicine_screen.dart';
import 'package:flutter_medimind_app/services/anonymous_auth_service.dart';
import 'package:flutter_medimind_app/services/authentication_service.dart';
import 'package:flutter_medimind_app/services/firestore_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../widgets/todays_medicine.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var patientName =
        Provider.of<AnonymousAuthService>(context, listen: false).patientName;
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Container(
          margin: EdgeInsets.only(left: 15),
          child: Text(
            'My Pills',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: orange, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.person_pin,
              color: orange,
              size: 35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: _screenSize.height * 0.25,
                  color: lavendar,
                ),
                Positioned(
                  top: (_screenSize.height * 0.25) / 4,
                  left: _screenSize.width * 0.1,
                  child: Container(
                    width: _screenSize.width * 0.5,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: _screenSize.width * 0.5,
                          child: Text(
                            'Hi $patientName',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: _screenSize.height * 0.03,
                        ),
                        Container(
                          width: _screenSize.width * 0.6,
                          child: Text(
                            'Welcome!\nBegin your journey by logging in your medications below.',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: cyan,
                                      fontWeight: FontWeight.bold,
                                    ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 50,
                  child: SvgPicture.asset(
                    'assets/images/medicalkit.svg',
                    height: _screenSize.height * 0.12,
                    width: _screenSize.width * 0.1,
                  ),
                ),
              ],
            ),
            SizedBox(height: _screenSize.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: _screenSize.height * 0.60,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleRow(),
                      Consumer<FireStoreService>(
                          builder: (context, firestore, child) {
                        String? patientUID = Provider.of<AnonymousAuthService>(
                                context,
                                listen: false)
                            .uid;
                        String? careTakerUID =
                            Provider.of<AuthService>(context, listen: false)
                                .uid;

                        return TodaysMedicinesListView(
                          patientUserStream: firestore
                              .getThePatient(patientUID ?? careTakerUID!),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Medicine Log Table',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddMedicineScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.add_box_rounded,
            size: 35,
            color: orange,
          ),
        ),
      ],
    );
  }
}
