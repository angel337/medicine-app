import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_medimind_app/models/patient_user.dart';

class AnonymousAuthService extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? uid;
  User? user = FirebaseAuth.instance.currentUser;
  PatientUser? _patientUser;
  String? patientName;
  String? _deviceToken;

  setTheUID(String? theUID) {
    uid = theUID;
    notifyListeners();
  }

  setTheName(String name) {
    patientName = name;
    notifyListeners();
  }

  setTheUser(User? theUser) {
    user = theUser;
    notifyListeners();
  }

  setTheToken(String token) {
    _deviceToken = token;
    notifyListeners();
  }

  Future signInAnonymously() {
    get_DeviceToken();
    return _firebaseAuth.signInAnonymously().then((theCredential) {
      print('//////////////////////user logged in.');
      setTheUID(theCredential.user!.uid);
      setTheUser(theCredential.user!);
      get_DeviceToken();
      savePatientToFirestore();
    });
  }

  get_DeviceToken() {
    _firebaseMessaging.getToken().then((token) {
      setTheToken(token!);
    });
  }

  savePatientToFirestore() {
    _patientUser = PatientUser(
        uid: user!.uid,
        name: patientName!,
        medicinesList: [],
        careTakerList: [],
        tokens: [_deviceToken!],
        isActive: true);

    // if()
    _firestore.collection('patients').doc(user!.uid).set(_patientUser!.toMap());
  }

  void signOut() {
    _firebaseAuth.signOut();
    setTheUser(null);
  }
}
