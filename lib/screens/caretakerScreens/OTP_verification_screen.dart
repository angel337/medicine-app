import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/caretaker_invitation_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../services/authentication_service.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({Key? key, required this.phoneNo})
      : super(key: key);
  final String phoneNo;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController _smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(25),
              width: _screenSize.width * 0.9,
              height: _screenSize.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter SMS Code',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: blackColor,
                        ),
                  ),
                  SizedBox(
                    height: _screenSize.height * 0.05,
                  ),
                  Text(
                      'We have sent you an SMS with the code to ${widget.phoneNo}',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: _screenSize.height * 0.08,
                  ),
                  PinCodeTextField(
                    controller: _smsController,
                    autoFocus: true,
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    length: 6,
                    onChanged: (s) {},
                    appContext: context,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      activeColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      inactiveColor: Colors.grey,
                      shape: PinCodeFieldShape.circle,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: _screenSize.height * 0.04,
                      fieldWidth: _screenSize.height * 0.04,
                    ),
                  ),
                  SizedBox(
                    height: _screenSize.height * 0.05,
                  ),
                  Text(
                    'NOTE: Default code is 123456 for app demo. This will be a future feature',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: _screenSize.height * 0.07,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print('++++++++++++++++++++++++++++++++++ Sms is :' +
                          _smsController.text);
                      Provider.of<AuthService>(context, listen: false)
                          .setTheSmsCode(_smsController.text);
                      Provider.of<AuthService>(context, listen: false)
                          .verifySmsCode()
                          .then((_) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: ((context) => caretakerInvitationScreen()),
                          ),
                        );
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
                            _screenSize.width * 0.7, _screenSize.height * 0.06),
                        primary: orange // put the width and height you want
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
