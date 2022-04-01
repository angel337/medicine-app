// import 'package:flutter/material.dart';
// import 'package:flutter_darmanakanm_app/constants.dart';
// import 'package:flutter_darmanakanm_app/main.dart';
// import 'package:flutter_darmanakanm_app/models/caretaker_user.dart';
// import 'package:flutter_darmanakanm_app/models/patient_user.dart';
// import 'package:flutter_darmanakanm_app/services/authentication_service.dart';
// import 'package:flutter_darmanakanm_app/services/firestore_service.dart';
// import 'package:provider/provider.dart';

// import '../../services/anonymous_auth_service.dart';

// class CaretakerProfileScreen extends StatefulWidget {
//   const CaretakerProfileScreen({Key? key}) : super(key: key);

//   @override
//   _CaretakerProfileScreenState createState() => _CaretakerProfileScreenState();
// }

// class _CaretakerProfileScreenState extends State<CaretakerProfileScreen> {
//   TextEditingController phoneController = TextEditingController();
//   bool user_expaned = false;
//   Icon expand_more = Icon(Icons.navigate_next);
//   bool notification_expaned = false;
//   Icon notification_more = Icon(Icons.navigate_next);
//   bool appe_expanded = false;
//   Icon appe_more = Icon(Icons.navigate_next);
//   String notification_val = "ON";
//   bool notefication = true;
//   @override
//   Widget build(BuildContext context) {
//     var caretakerUID = Provider.of<AuthService>(context).uid;
//     Size _screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           "Profile",
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white10,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding:
//                   const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 child: ListView(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                                 backgroundColor: orange,
//                                 child: Icon(
//                                   Icons.person_rounded,
//                                   color: whiteColor,
//                                 )),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               children: [
//                                 Container(
//                                   width: _screenSize.width * 0.32,
//                                   child: Text(
//                                     "Sumaya Saber",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headline6!
//                                         .copyWith(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                 ),
//                                 Container(
//                                   width: _screenSize.width * 0.32,
//                                   child: Text(
//                                     "Caretaker (YOU)",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyText2!
//                                         .copyWith(
//                                           color: blackColor.withOpacity(0.5),
//                                         ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.emoji_people,
//                               size: 30,
//                               color: orange,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               "You are a care taker",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleMedium!
//                                   .copyWith(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 if (appe_expanded == false) {
//                                   appe_more = const Icon(Icons.expand_more);
//                                   appe_expanded = true;
//                                 } else {
//                                   appe_more = const Icon(Icons.navigate_next);
//                                   appe_expanded = false;
//                                 }
//                               });
//                             },
//                             iconSize: 34,
//                             icon: appe_more),
//                       ],
//                     ),
//                     Visibility(
//                       visible: appe_expanded,
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 12.0),
//                             child: Text(
//                               'You are taking care of below patients:',
//                               style: Theme.of(context).textTheme.subtitle1,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             width: _screenSize.width * 0.85,
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Text(
//                                 'Patient names: ',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle1!
//                                     .copyWith(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           FutureBuilder<CaretakerUser>(
//                               future: Provider.of<FireStoreService>(context)
//                                   .getCaretaker(caretakerUID!),
//                               builder: (context, snapshot) {
//                                 if (!snapshot.hasData) {
//                                   return Center(
//                                     child: CircularProgressIndicator(),
//                                   );
//                                 } else if (snapshot.hasError) {
//                                   return Text('Error');
//                                 }

//                                 return ListView.builder(
//                                     itemBuilder: (context, index) {
//                                   List<PatientUser> trackedPatients =
//                                       snapshot.data!.trackedPatients;
//                                   return Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Container(
//                                           height: _screenSize.height * 0.06,
//                                           width: _screenSize.width * 0.6,
//                                           child: Container(
//                                             child: Text(
//                                                 trackedPatients[index].name),
//                                           )),
//                                       ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           primary: redColor,
//                                         ),
//                                         onPressed: () {},
//                                         child: const Text("Remove"),
//                                       )
//                                     ],
//                                   );
//                                 });
//                               }),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.notifications,
//                                   color: orange,
//                                   size: 25,
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   "Notification",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleMedium!
//                                       .copyWith(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (notification_expaned == false) {
//                                       notification_more =
//                                           const Icon(Icons.expand_more);
//                                       notification_expaned = true;
//                                     } else {
//                                       notification_more =
//                                           const Icon(Icons.navigate_next);
//                                       notification_expaned = false;
//                                     }
//                                   });
//                                 },
//                                 iconSize: 34,
//                                 icon: notification_more),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: notification_expaned,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(notification_val),
//                           Switch.adaptive(
//                             value: notefication,
//                             onChanged: (val) {
//                               setState(() {
//                                 notefication = val;
//                                 if (notefication == false) {
//                                   notification_val = "OFF";
//                                 } else {
//                                   notification_val = "ON";
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: _screenSize.height * 0.05,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Provider.of<AnonymousAuthService>(context,
//                                   listen: false)
//                               .signOut();
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                               builder: ((context) => AuthenticationWrapper()),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Log Out',
//                           style: Theme.of(context).textTheme.button!.copyWith(
//                                 color: whiteColor,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           primary: redColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
