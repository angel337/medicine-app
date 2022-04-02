import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/config.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/main.dart';

import 'package:flutter_medimind_app/models/caretaker_user.dart';
import 'package:flutter_medimind_app/models/patient_user.dart';
import 'package:flutter_medimind_app/screens/patientScreens/bottom_nav_handler.dart';
import 'package:flutter_medimind_app/services/anonymous_auth_service.dart';
import 'package:provider/provider.dart';

import '../services/authentication_service.dart';

class CaretakerInvited extends StatefulWidget {
  Future<CaretakerUser> theCaretakerUser;
  CaretakerInvited({
    Key? key,
    required this.theCaretakerUser,
  }) : super(key: key);

  @override
  _CaretakerInvitedState createState() => _CaretakerInvitedState();
}

class _CaretakerInvitedState extends State<CaretakerInvited> {
  List<PatientUser> trackedPatients = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(60),
          ),
          Container(
            width: getProportionateScreenWidth(700),
            child: Text(
              "Patients assigned to you are  :",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          FutureBuilder<CaretakerUser>(
            future: widget.theCaretakerUser,
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Text('Error');
              }
              return Container(
                height: getProportionateScreenHeight(120),
                child: ListView.builder(
                    itemCount: snapshot.data!.trackedPatients.length,
                    itemBuilder: (context, index) {
                      var trackedPatientList = snapshot.data!.trackedPatients;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 10),
                            child: Container(
                              color: bitGreyish,
                              child: Text(
                                '${index + 1}. ' +
                                    trackedPatientList[index].name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              );
            }),
          ),
          Container(
            height: getProportionateScreenHeight(120),
            child: Image.asset('assets/images/success.jpg'),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Container(
            width: getProportionateScreenWidth(600),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'You will be notified in due time',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Text(
            'Tracking Log:',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          FutureBuilder<CaretakerUser>(
            future: widget.theCaretakerUser,
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Text('Error');
              }
              return Container(
                height: getProportionateScreenHeight(250),
                child: ListView.builder(
                    itemCount: snapshot.data!.trackedPatients.length,
                    itemBuilder: (context, index) {
                      var trackedPatientList = snapshot.data!.trackedPatients;
                      return patientCard(trackedPatientList[index]);
                    }),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget patientCard(PatientUser thePatient) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
      child: ListTile(
        onTap: () {
          Provider.of<AnonymousAuthService>(context, listen: false)
              .setTheName(thePatient.name);

          Provider.of<AnonymousAuthService>(context, listen: false)
              .setTheUID(thePatient.uid);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: ((context) => BottomNavHandler()),
            ),
          );
        },
        tileColor: lavendar,
        title: Text(
          thePatient.name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
          textAlign: TextAlign.center,
        ),
        trailing: ElevatedButton(
          child: Text('Untrack'),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: redColor,
            minimumSize: Size(
              getProportionateScreenWidth(30),
              getProportionateScreenHeight(40),
            ),
          ),
        ),
      ),
    );
  }
}
