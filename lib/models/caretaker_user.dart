import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_medimind_app/models/patient_user.dart';

class CaretakerUser {
  String uid;
  String name;
  String phoneNo;
  List<PatientUser> trackedPatients;
  List<String> tokens;
  DocumentReference? reference;
  CaretakerUser({
    required this.uid,
    required this.name,
    required this.phoneNo,
    required this.trackedPatients,
    required this.tokens,
    this.reference,
  });

  CaretakerUser copyWith({
    String? uid,
    String? name,
    String? phoneNo,
    List<PatientUser>? trackedPatients,
    List<String>? tokens,
    DocumentReference? reference,
  }) {
    return CaretakerUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      trackedPatients: trackedPatients ?? this.trackedPatients,
      tokens: tokens ?? this.tokens,
      reference: reference ?? this.reference,
    );
  }

  factory CaretakerUser.fromSnapshot(DocumentSnapshot snapshot) {
    CaretakerUser theCaretaker =
        CaretakerUser.fromMap(snapshot.data() as Map<String, dynamic>);
    theCaretaker.reference = snapshot.reference;
    return theCaretaker;
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNo': phoneNo,
      'trackedPatients': trackedPatients.map((x) => x.toMap()).toList(),
      'tokens': tokens,
      'reference': reference,
    };
  }

  factory CaretakerUser.fromMap(Map<String, dynamic> map) {
    return CaretakerUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      trackedPatients: List<PatientUser>.from(
          map['trackedPatients']?.map((x) => PatientUser.fromMap(x))),
      tokens: List<String>.from(map['tokens']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CaretakerUser.fromJson(String source) =>
      CaretakerUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CaretakerUser(uid: $uid, name: $name, phoneNo: $phoneNo, trackedPatients: $trackedPatients, tokens: $tokens, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CaretakerUser &&
        other.uid == uid &&
        other.name == name &&
        other.phoneNo == phoneNo &&
        listEquals(other.trackedPatients, trackedPatients) &&
        listEquals(other.tokens, tokens) &&
        other.reference == reference;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        phoneNo.hashCode ^
        trackedPatients.hashCode ^
        tokens.hashCode ^
        reference.hashCode;
  }
}
