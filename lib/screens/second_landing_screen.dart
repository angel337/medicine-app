import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/caretaker_sign_in.dart';
import 'package:flutter_medimind_app/screens/patientScreens/patient_sign_in.dart';

import '../widgets/circular_image.dart';

class SecondLandingScreen extends StatelessWidget {
  const SecondLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: orange,
      ),
      backgroundColor: orange,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularImage(imagePath: 'assets/images/login.jpg'),
              SizedBox(
                height: _screenSize.height * 0.05,
              ),
              Text(
                'Login Page',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold, color: whiteColor),
              ),
              SizedBox(
                height: _screenSize.height * 0.04,
              ),
              Text(
                '''Log in your medication and set reminders''',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: bitGreyish,
                      fontSize: 16,
                    ),
              ),
              SizedBox(
                height: _screenSize.height * 0.02,
              ),
              Text(
                '''OR''',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: bitGreyish,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: _screenSize.height * 0.02,
              ),
              Text(
                '''Add in your caretakers for additional support''',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: bitGreyish,
                      fontSize: 16,
                    ),
              ),
              SizedBox(
                height: _screenSize.height * 0.07,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PatientSignInScreen()));
                  },
                  label: Text(
                    'Patient',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: whiteColor,
                        ),
                  ),
                  style: ElevatedButton.styleFrom(
                    onPrimary: whiteColor,
                    shape: StadiumBorder(),
                    primary: cyan,
                    minimumSize: Size(
                        _screenSize.height * 0.19, _screenSize.height * 0.05),
                  ),
                  icon: Icon(Icons.arrow_back_ios_rounded, size: 15),
                ),
              ),
              SizedBox(
                height: _screenSize.height * 0.02,
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Divider(
                    color: whiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "OR",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: whiteColor,
                        ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: whiteColor,
                  ),
                ),
              ]),
              SizedBox(
                height: _screenSize.height * 0.02,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CaretakerSignInScreen()));
                  },
                  label: Text(
                    'Caretaker',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: whiteColor,
                        ),
                  ),
                  style: ElevatedButton.styleFrom(
                    onPrimary: whiteColor,
                    shape: StadiumBorder(),
                    primary: lightGreenColor,
                    minimumSize: Size(
                        _screenSize.height * 0.19, _screenSize.height * 0.05),
                  ),
                  icon: Icon(Icons.arrow_back_ios_rounded, size: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
