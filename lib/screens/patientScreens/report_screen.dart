import 'package:flutter/material.dart';

import '../../config.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
    height: getProportionateScreenHeight(70),
    ),
    Container(
      child: Text(
        'Medications taken in the last 2 months',
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    ),
    SizedBox(
    height: getProportionateScreenHeight(40),
    ),
    Container(
    height: getProportionateScreenHeight(450),
    width: getProportionateScreenWidth(550),
    child: Image.asset('assets/images/reportfinal2.jpg'),
    ),
    SizedBox(
    height: getProportionateScreenHeight(60),
    ),

    ],
    ),
        ),
    );
  }
}


      // return Container(
      //        height: 550.0,
      //        width: 600.0,
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           image: AssetImage(
      //               'assets/images/reportfinal2.jpg'),
      //           //fit: BoxFit.fill,
      //         ),
      //         // shape: BoxShape.circle,
      //       ),
      //     );














