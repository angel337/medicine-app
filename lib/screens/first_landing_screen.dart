import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/screens/second_landing_screen.dart';

import '../widgets/circular_image.dart';

class FirstLandingScreen extends StatelessWidget {
  const FirstLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularImage(imagePath: 'assets/images/welcome.jpg'),
              SizedBox(
                height: _ScreenSize.height * 0.07,
              ),
              Text(
                'Welcome to MediMind',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold, color: orange),
              ),
              SizedBox(
                height: _ScreenSize.height * 0.04,
              ),
              Text(
                '''Bridging technology and medicine since 2021''',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: greyishColor,
                      fontSize: 16,
                    ),
              ),
              SizedBox(
                height: _ScreenSize.height * 0.04,
              ),
              Text(
                '''Start your journey with us,click Next below.''',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: greyishColor,
                      fontSize: 16,
                    ),
              ),
              SizedBox(
                height: _ScreenSize.height * 0.07,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SecondLandingScreen()));
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
                    primary: cyan,
                    minimumSize: Size(
                        _ScreenSize.height * 0.19, _ScreenSize.height * 0.05),
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
