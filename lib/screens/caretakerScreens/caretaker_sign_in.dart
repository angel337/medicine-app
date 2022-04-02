import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/screens/caretakerScreens/verification_screen.dart';
import 'package:flutter_medimind_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class CaretakerSignInScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkGray,
      ),
      backgroundColor: darkGray,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Caretaker login',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: _screenSize.height * 0.05,
              ),
              Text(
                '''Add your name and phone number to receive updates''',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: bitGreyish,
                      fontSize: 16,
                    ),
              ),
              SizedBox(
                height: _screenSize.height * 0.07,
              ),

              Form(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  child: TextFormField(
                    style: TextStyle(color: whiteColor),
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle:
                          Theme.of(context).textTheme.headline6!.copyWith(
                                color: whiteColor,
                              ),
                      hintText: 'e.g John',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: bitGreyish,
                              ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _screenSize.height * 0.05,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<AuthService>(context, listen: false)
                        .setTheName(_nameController.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VerificationScreen(),
                      ),
                    );
                  },
                  label: Text(
                    'Next',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: whiteColor,
                        ),
                  ),
                  style: ElevatedButton.styleFrom(
                    onPrimary: whiteColor,
                    shape: StadiumBorder(),
                    primary: cadetBlue,
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
