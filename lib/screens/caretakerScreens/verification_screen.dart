// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/OTP_verification_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../services/authentication_service.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? phoneNo;
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    _screenSize.height * 0.04,
                    _screenSize.height * 0.2,
                    _screenSize.height * 0.04,
                    _screenSize.height * 0.02),
                child: Text(
                  'Enter Your Phone Number',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: Container(
                  margin: EdgeInsets.only(top: _screenSize.height * 0.01),
                  child: Text(
                      'Select appropriate country code',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
              ),
              SizedBox(
                height: _screenSize.height * 0.08,
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  phoneNo = number.phoneNumber!;
                },
                errorMessage: 'please enter your phone number',
                autoFocus: true,
                cursorColor: Colors.blue,
                keyboardType: TextInputType.phone,
                textStyle: Theme.of(context).textTheme.bodyText1,
                spaceBetweenSelectorAndTextField: 0,
                selectorTextStyle: Theme.of(context).textTheme.bodyText1,
                inputDecoration: InputDecoration(
                    hintText: 'Phone number',
                    hintStyle: TextStyle(color: greyishColor),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[100],
                    constraints:
                        BoxConstraints(maxWidth: _screenSize.width * 0.6)),
                searchBoxDecoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: grayWhitesh,
                    constraints: BoxConstraints(maxWidth: 5)),
              ),
              SizedBox(
                height: _screenSize.height * 0.12,
              ),
              ElevatedButton(
                onPressed: () async {
                  Provider.of<AuthService>(context, listen: false)
                      .setPhoneNumber(phoneNo!);
                  Provider.of<AuthService>(context, listen: false)
                      .verifyPhoneNumber()
                      .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPVerificationScreen(
                          phoneNo: phoneNo!,
                        ),
                      ),
                    );
                    setState(() {});
                  });
                },
                child: Text(
                  'Continue',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                        _screenSize.width * 0.7, _screenSize.height * 0.07),
                    primary: orange // put the width and height you want
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
