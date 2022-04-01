import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/models/caretaker_user.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CaretakerUser? _caretakerUser;
  String? phoneNumber;
  String? smsCode;
  String? verificationID;
  String? name;
  String? uid;
  String? deviceToken;
  User? user = FirebaseAuth.instance.currentUser;

  void setUserAndUID(User? aUser, String? UID) {
    user = aUser;
    uid = UID;
    notifyListeners();
  }

  void setTheToken(String token) {
    deviceToken = token;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNum) {
    phoneNumber = phoneNum;
    notifyListeners();
  }

  void setTheSmsCode(String theSmsCode) {
    smsCode = theSmsCode;
    notifyListeners();
  }

  void setTheVerificationID(String theVerificationID) {
    debugPrint(theVerificationID);
    verificationID = theVerificationID;
    notifyListeners();
  }

  void setTheName(String theName) {
    debugPrint(theName);
    name = theName;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint('verification completed');
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint('failed ${e.toString()}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setTheVerificationID(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future verifySmsCode() async {
    getDeviceToken();

// returns a user credential
    PhoneAuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: smsCode!);

    UserCredential _userCredential =
        await _auth.signInWithCredential(_credential);
    setUserAndUID(_userCredential.user, _userCredential.user!.uid);
    saveCaretakerToFirestore();
  }

  getDeviceToken() {
    _firebaseMessaging.getToken().then((token) {
      setTheToken(token!);
    });
  }

  saveCaretakerToFirestore() {
    Future<List<CaretakerUser>> listOfCaretakerFuture = _firestore
        .collection('caretakers')
        .where('phoneNo', isEqualTo: phoneNumber)
        .get()
        .then(
          (value) => value.docs
              .map(
                (snapshot) => CaretakerUser.fromSnapshot(snapshot),
              )
              .toList(),
        );

    listOfCaretakerFuture.then((caretakerList) {
      if (caretakerList.isEmpty) {
        _caretakerUser = CaretakerUser(
            uid: user!.uid,
            name: name!,
            phoneNo: phoneNumber!,
            trackedPatients: [],
            tokens: [deviceToken!]);

        _firestore
            .collection('caretakers')
            .doc(user!.uid)
            .set(_caretakerUser!.toMap());
      }
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
    setUserAndUID(null, null);
  }
}
