import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/main.dart';
import 'package:flutter_medimind_app/models/patient_user.dart';
import 'package:flutter_medimind_app/services/authentication_service.dart';
import 'package:flutter_medimind_app/services/firestore_service.dart';
import 'package:provider/provider.dart';

import '../../services/anonymous_auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController phoneController = TextEditingController();
  bool user_expaned = false;
  Icon expand_more = Icon(Icons.navigate_next);
  bool notification_expaned = false;
  Icon notification_more = Icon(Icons.navigate_next);
  bool appe_expanded = false;
  Icon appe_more = Icon(Icons.navigate_next);
  String notification_val = "ON";
  bool notefication = true;
  @override
  Widget build(BuildContext context) {
    bool isPatientNull = Provider.of<AnonymousAuthService>(context).uid == null;
    bool isCaretakerNull = Provider.of<AuthService>(context).uid == null;
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        //removing back arrow button
        // automaticallyImplyLeading: false,
        //backgroundColor: const Color(0xFFFFFFFF),
        backgroundColor: Colors.white10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: orange,
                                child: Icon(
                                  Icons.person_rounded,
                                  color: whiteColor,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: _screenSize.width * 0.32,
                                  child: Text(
                                    Provider.of<AnonymousAuthService>(context)
                                        .patientName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  width: _screenSize.width * 0.32,
                                  child: Text(
                                    "Patient",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: blackColor.withOpacity(0.5),
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (isCaretakerNull)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.emoji_people,
                                size: 30,
                                color: orange,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Register a caretaker below",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (appe_expanded == false) {
                                    appe_more = const Icon(Icons.expand_more);
                                    appe_expanded = true;
                                  } else {
                                    appe_more = const Icon(Icons.navigate_next);
                                    appe_expanded = false;
                                  }
                                });
                              },
                              iconSize: 34,
                              icon: appe_more)
                        ],
                      ),
                    Visibility(
                      visible: appe_expanded,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Add a caretaker by logging in with a phone number below ',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: _screenSize.width * 0.85,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Add the care taker’s phone number: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: _screenSize.height * 0.06,
                                width: _screenSize.width * 0.6,
                                child: TextField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    label: Text("+XXX XXX-XXX-XXXX"),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0,
                                          color: Colors.grey.shade100,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String? patientUID =
                                      Provider.of<AnonymousAuthService>(context,
                                              listen: false)
                                          .uid;
                                  PatientUser? thePatientUser;
                                  Provider.of<FireStoreService>(context,
                                          listen: false)
                                      .getThePatientOnce(patientUID!)
                                      .then((value) {
                                    thePatientUser = value;
                                    bool isAddedSuccessfully;
                                    Provider.of<FireStoreService>(context,
                                            listen: false)
                                        .addCaretaker(phoneController.text,
                                            thePatientUser!)
                                        .then((isAddedValue) {
                                      if (isAddedValue) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'adding the caretaker succeeded.'),
                                          ),
                                        );
                                        phoneController.clear();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'adding the caretaker failed.'),
                                          ),
                                        );
                                      }
                                    });
                                  });
                                },
                                child: const Text("Add"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: orange,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Notification",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (notification_expaned == false) {
                                      notification_more =
                                          const Icon(Icons.expand_more);
                                      notification_expaned = true;
                                    } else {
                                      notification_more =
                                          const Icon(Icons.navigate_next);
                                      notification_expaned = false;
                                    }
                                  });
                                },
                                iconSize: 34,
                                icon: notification_more),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: notification_expaned,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(notification_val),
                          Switch.adaptive(
                            value: notefication,
                            onChanged: (val) {
                              setState(() {
                                notefication = val;
                                if (notefication == false) {
                                  notification_val = "OFF";
                                } else {
                                  notification_val = "ON";
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _screenSize.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<AnonymousAuthService>(context,
                                  listen: false)
                              .signOut();
                          Provider.of<AnonymousAuthService>(context,
                                  listen: false)
                              .setTheUID(null);

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AuthenticationWrapper()),
                              (route) => false);
                        },
                        child: Text(
                          'Log Out',
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: redColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
