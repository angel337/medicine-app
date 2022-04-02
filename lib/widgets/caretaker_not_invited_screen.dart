import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/config.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class CaretakerNotInvited extends StatelessWidget {
  const CaretakerNotInvited({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Container(
              child: Text(
                'You as a Caretaker are not assigned any patients.',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Container(
              height: getProportionateScreenHeight(170),
              width: getProportionateScreenWidth(170),
              child: Image.asset('assets/images/fail.jpg'),
            ),
            SizedBox(
              height: getProportionateScreenHeight(60),
            ),
            Container(
              child: Text(
                'If you are the care taker of someone, -> Go to patient account -> Profile -> Register your Phone number to become a Caretaker.',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(60),
            ),
            Container(
              // height: SizeConfig.,
              // color: Colors.blueAccent,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: whiteColor,
                  shape: StadiumBorder(),
                  primary: lightGreenColor,
                  minimumSize: Size(
                    getProportionateScreenWidth(400),
                    getProportionateScreenHeight(40),
                  ),
                ),
                child: Text('Log Out'),
                onPressed: () {
                  Provider.of<AuthService>(context, listen: false).signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
