import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_medimind_app/models/caretaker_user.dart';
import 'package:flutter_medimind_app/models/medicine.dart';

class PatientUser {
  String uid;
  String name;
  List<Medicine> medicinesList;
  List<CaretakerUser> careTakerList;
  List<String> tokens;
  bool isActive;
  DocumentReference? reference;
// fromSnapshot method to get data and reference.
  factory PatientUser.fromSnapshot(DocumentSnapshot snapshot) {
    PatientUser patientUser =
        PatientUser.fromMap(snapshot.data() as Map<String, dynamic>);
    patientUser.reference = snapshot.reference;
    return patientUser;
  }
  PatientUser({
    required this.uid,
    required this.name,
    required this.medicinesList,
    required this.careTakerList,
    required this.tokens,
    required this.isActive,
    this.reference,
  });

  PatientUser copyWith({
    String? uid,
    String? name,
    List<Medicine>? medicinesList,
    List<CaretakerUser>? careTakerList,
    List<String>? tokens,
    bool? isActive,
    DocumentReference? reference,
  }) {
    return PatientUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      medicinesList: medicinesList ?? this.medicinesList,
      careTakerList: careTakerList ?? this.careTakerList,
      tokens: tokens ?? this.tokens,
      isActive: isActive ?? this.isActive,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'medicinesList': medicinesList.map((x) => x.toMap()).toList(),
      'careTakerList': careTakerList.map((x) => x.toMap()).toList(),
      'tokens': tokens,
      'isActive': isActive,
      'reference': reference,
    };
  }

  factory PatientUser.fromMap(Map<String, dynamic> map) {
    return PatientUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      medicinesList: List<Medicine>.from(
          map['medicinesList']?.map((x) => Medicine.fromMap(x))),
      careTakerList: List<CaretakerUser>.from(
          map['careTakerList']?.map((x) => CaretakerUser.fromMap(x))),
      tokens: List<String>.from(map['tokens']),
      isActive: map['isActive'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientUser.fromJson(String source) =>
      PatientUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PatientUser(uid: $uid, name: $name, medicinesList: $medicinesList, careTakerList: $careTakerList, tokens: $tokens, isActive: $isActive, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PatientUser &&
        other.uid == uid &&
        other.name == name &&
        listEquals(other.medicinesList, medicinesList) &&
        listEquals(other.careTakerList, careTakerList) &&
        listEquals(other.tokens, tokens) &&
        other.isActive == isActive &&
        other.reference == reference;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        medicinesList.hashCode ^
        careTakerList.hashCode ^
        tokens.hashCode ^
        isActive.hashCode ^
        reference.hashCode;
  }
}
