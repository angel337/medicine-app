import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_medimind_app/models/days.dart';
import 'package:flutter_medimind_app/models/frequencyType.dart';
import 'package:flutter_medimind_app/models/status.dart';

class Medicine {
  String id;
  String name;
  double dosage;
  Timestamp startDate;
  DateTime? duration;
  Timestamp endDate;
  FrequencyType frequency;
  List<Days>? selectedDays;
  List<String> reminderTimes;
  DocumentReference? reference;
  Status currentStatus;
  String? imageUrl;
  bool isSatSelected;
  bool isSunSelected;
  bool isFriSelected;
  bool isMonSelected;
  bool isTueSelected;
  bool isWedSelected;
  bool isThuSelected;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.startDate,
    this.duration,
    required this.endDate,
    required this.frequency,
    this.selectedDays,
    required this.reminderTimes,
    this.reference,
    required this.currentStatus,
    this.imageUrl,
    this.isSatSelected = false,
    this.isSunSelected = false,
    this.isFriSelected = false,
    this.isMonSelected = false,
    this.isTueSelected = false,
    this.isWedSelected = false,
    this.isThuSelected = false
  });

  Medicine copyWith({
    String? id,
    String? name,
    double? dosage,
    Timestamp? startDate,
    DateTime? duration,
    Timestamp? endDate,
    FrequencyType? frequency,
    List<Days>? selectedDays,
    List<String>? reminderTimes,
    DocumentReference? reference,
    Status? currentStatus,
    String? imageUrl,
    bool? isSatSelected,
    bool? isSunSelected,
    bool? isFriSelected,
    bool? isMonSelected,
    bool? isTueSelected,
    bool? isWedSelected,
    bool? isThuSelected

  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      startDate: startDate ?? this.startDate,
      duration: duration ?? this.duration,
      endDate: endDate ?? this.endDate,
      frequency: frequency ?? this.frequency,
      selectedDays: selectedDays ?? this.selectedDays,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      reference: reference ?? this.reference,
      currentStatus: currentStatus ?? this.currentStatus,
      imageUrl: imageUrl ?? this.imageUrl,
      isSatSelected: isSatSelected ?? this.isSatSelected,
      isSunSelected: isSunSelected ?? this.isSunSelected,
      isFriSelected: isFriSelected ?? this.isFriSelected,
      isMonSelected: isMonSelected ?? this.isMonSelected,
      isTueSelected: isTueSelected ?? this.isTueSelected,
      isWedSelected: isWedSelected ?? this.isWedSelected,
      isThuSelected: isThuSelected ?? this.isThuSelected
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'startDate': startDate,
      'endDate': endDate,
      'frequency': frequency.toMap(),
      'selectedDays': selectedDays != null
          ? selectedDays?.map((x) => x.toMap()).toList()
          : null,
      'reminderTimes': reminderTimes,
      'reference': reference,
      'currentStatus': currentStatus.toMap(),
      'imageUrl': imageUrl,
      'isMonSelected': isMonSelected,
      'isTueSelected': isTueSelected,
      'isWedSelected': isWedSelected,
      'isThuSelected': isThuSelected,
      'isFriSelected': isFriSelected,
      'isSatSelected': isSatSelected,
      'isSunSelected': isSunSelected
    };
  }

  factory Medicine.fromSnapshot(DocumentSnapshot snapshot) {
    Medicine theMedicine =
        Medicine.fromMap(snapshot.data() as Map<String, dynamic>);
    theMedicine.reference = snapshot.reference;
    return theMedicine;
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      dosage: map['dosage']?.toDouble() ?? 0.0,
      startDate: map['startDate'],
      endDate: map['endDate'],
      frequency: FrequencyType.fromMap(map['frequency']),
      // to choose selectedDays:
      //     List<Days>.from(map['selectedDays']?.map((x) => Days.fromMap(x))),
      reminderTimes: List<String>.from(map['reminderTimes']),
      currentStatus: Status.fromMap(map['currentStatus']),
      imageUrl: map['imageUrl'] ?? '',
      isWedSelected: map['isWedSelected'] ?? false,
      isThuSelected: map['isThuSelected'] ?? false,
      isFriSelected: map['isFriSelected'] ?? false,
      isSatSelected: map['isSatSelected'] ?? false,
      isSunSelected: map['isSunSelected'] ?? false,
      isMonSelected: map['isMonSelected'] ?? false,
      isTueSelected: map['isTueSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Medicine.fromJson(String source) =>
      Medicine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Medicine(id: $id, name: $name, dosage: $dosage, startDate: $startDate, duration: $duration, endDate: $endDate, frequency: $frequency, selectedDays: $selectedDays, reminderTimes: $reminderTimes, reference: $reference, currentStatus: $currentStatus, imageUrl: $imageUrl)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Medicine &&
  //       other.id == id &&
  //       other.name == name &&
  //       other.dosage == dosage &&
  //       other.startDate == startDate &&
  //       other.duration == duration &&
  //       other.endDate == endDate &&
  //       other.frequency == frequency &&
  //       listEquals(other.selectedDays, selectedDays) &&
  //       listEquals(other.reminderTimes, reminderTimes) &&
  //       other.reference == reference &&
  //       other.currentStatus == currentStatus &&
  //       other.imageUrl == imageUrl;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //       name.hashCode ^
  //       dosage.hashCode ^
  //       startDate.hashCode ^
  //       duration.hashCode ^
  //       endDate.hashCode ^
  //       frequency.hashCode ^
  //       selectedDays.hashCode ^
  //       reminderTimes.hashCode ^
  //       reference.hashCode ^
  //       currentStatus.hashCode ^
  //       imageUrl.hashCode;
  // }
}
