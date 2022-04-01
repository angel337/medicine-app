import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_medimind_app/models/caretaker_user.dart';
import 'package:flutter_medimind_app/models/medicine.dart';
import 'package:flutter_medimind_app/models/patient_user.dart';
import 'package:flutter_medimind_app/models/status.dart';

class FireStoreService extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  PatientUser? thePatientUser;

  setTheUser(PatientUser patientUser) {
    thePatientUser = patientUser;
    notifyListeners();
  }

  Future<PatientUser> getThePatientByName(String name) {
     return _firestore
        .collection('patients')
        .where('name', isEqualTo: name)
        .get().then(
             (value) => value.docs
             .map((snapshot) => PatientUser.fromSnapshot(snapshot)).first);

  }

  Stream<PatientUser> getThePatient(String patientUID) {
    return _firestore
        .collection('patients')
      .doc(patientUID)
        .snapshots()
        .map((v) => PatientUser.fromSnapshot(v));
  }

  Future<PatientUser> getThePatientOnce(String patientUID) {
    return _firestore
        .collection('patients')
        .doc(patientUID)
        .get()
        .then((value) => PatientUser.fromSnapshot(value));
  }

  Future<bool> addCaretaker(String caretakerPhoneNo, PatientUser patientUser) {
    bool isAddedSuccessfully;
    Future<List<CaretakerUser>> caretakerUserListFuture = _firestore
        .collection('caretakers')
        .where('phoneNo', isEqualTo: caretakerPhoneNo)
        .get()
        .then(
          (snpashot) => snpashot.docs
              .map(
                (queryDoc) => CaretakerUser.fromSnapshot(queryDoc),
              )
              .toList(),
        );
    DocumentReference? theCaretakerRef;
    Future<bool> isAddedFuture;

    isAddedFuture = caretakerUserListFuture.then((caretakers) {
      if (caretakers.isEmpty) {
        isAddedSuccessfully = false;
      } else {
        theCaretakerRef = caretakers[0].reference!;

        theCaretakerRef!.update({
          'trackedPatients': FieldValue.arrayUnion([patientUser.toMap()]),
        });
        isAddedSuccessfully = true;
      }
      return isAddedSuccessfully;
    });
    return isAddedFuture;
  }

  takeMedicine(String patientUID, String medicineID, String time) {
    Future<PatientUser> patientUserFuture = getThePatientOnce(patientUID);

    patientUserFuture.then((patUser) {
      List<Medicine> medicinesList = patUser.medicinesList;
      for (var medicine in medicinesList) {
        if (medicine.id == medicineID) {
          medicine.reminderTimes.remove(time);
          if (medicine.reminderTimes.length == 0) {
            medicine.currentStatus =
                Status(isNotTaken: false, isTaken: true, isUnmarked: false);
          }
        }
      }
      _firestore.collection('patients').doc(patientUID).update(
        {
          'medicinesList': [],
        },
      );
      for (var theMedicine in medicinesList) {
        _firestore.collection('patients').doc(patientUID).update(
          {
            'medicinesList': FieldValue.arrayUnion([theMedicine.toMap()]),
          },
        );
      }
    });
  }

  addMedicineToFirestore(String userUID, Medicine theMedicine) {
    _firestore.collection('patients').doc(userUID).update({
      'medicinesList': FieldValue.arrayUnion([theMedicine.toMap()])
    });
  }

  Future<CaretakerUser> getCaretaker(String caretakerUID) {
    return _firestore
        .collection('caretakers')
        .doc(caretakerUID)
        .get()
        .then((value) => CaretakerUser.fromMap(value.data()!));
  }
}
