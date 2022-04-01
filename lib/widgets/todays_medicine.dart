import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/mock%20data/patient_data.dart';
import 'package:flutter_medimind_app/models/days.dart';
import 'package:flutter_medimind_app/models/medicine.dart';
import 'package:flutter_medimind_app/models/patient_user.dart';
import 'package:flutter_medimind_app/services/authentication_service.dart';
import 'package:flutter_medimind_app/services/firestore_service.dart';
import 'package:flutter_medimind_app/widgets/medicine_card.dart';

class TodaysMedicinesListView extends StatefulWidget {
  Stream<PatientUser> patientUserStream;
  TodaysMedicinesListView({
    Key? key,
    required this.patientUserStream,
  }) : super(key: key);

  @override
  _TodaysMedicinesListViewState createState() =>
      _TodaysMedicinesListViewState();
}

class _TodaysMedicinesListViewState extends State<TodaysMedicinesListView> {
  List<Medicine> medicinesList = [];
  List<Medicine?>? todaysMedicine;
  Map<String, List<Medicine>>? mappedMedicines;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // todaysMedicine = extractTodaysMedicine();
    // mappedMedicines = mapMedicinesToTime();
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    // mappedMedicines!.forEach(
    //   (key, value) {
    //     print('key: $key , value: $value');
    //   },
    // );
    // print('/////////////////////' + mappedMedicines!.length.toString());
    // print(todaysMedicine!.length.toString());
    // todaysMedicine!.forEach((element) {
    //   print('printing the medicines:');
    //   print(element);
    // });
    return StreamBuilder<PatientUser>(
      stream: widget.patientUserStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error');
        }
        medicinesList = snapshot.data!.medicinesList;
        todaysMedicine = extractTodaysMedicine();
        mappedMedicines = mapMedicinesToTime();
        return Container(
          // color: Colors.red,
          height: _screenSize.height * 0.52,
          width: double.infinity,
          child: ListView(
              children: mappedMedicines!.entries.map((entry) {
            int numberOfMedicines = entry.value.length;
            return Column(
              children: [
                TimeAndStatusRow(entry.key),
                Container(
                  height: _screenSize.height * 0.1 * numberOfMedicines,
                  child: Column(
                    children: entry.value
                        .map(
                          (theMedicine) => MedicineCard(
                              medicine: theMedicine, time: entry.key),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          }).toList()),
        );
      },
    );
  }

  mapMedicinesToTime() {
    SplayTreeMap<String, List<Medicine>> linkedMedicinesToTime =
        SplayTreeMap<String, List<Medicine>>();
    if (todaysMedicine != null) {
      for (int i = 0; i < todaysMedicine!.length; i++) {
        var selectedMedicine = todaysMedicine![i];
        // map each time to the medicine.
        List<String> selectedTimes = [...selectedMedicine!.reminderTimes];
        for (int j = 0; j < selectedTimes.length; j++) {
          String selectedTime = selectedTimes[j];
          var previousValues = linkedMedicinesToTime[selectedTime] ?? [];
          previousValues.add(selectedMedicine);
          // here previous values contains all the values new and old.
          linkedMedicinesToTime[selectedTime] = previousValues;
        }
      }
    }
    return linkedMedicinesToTime;
  }

  List<Medicine?> extractTodaysMedicine() {
    List<Medicine> todaysMedicinesExtracted = [];

    for (var theMedicine in medicinesList) {
      if (theMedicine.currentStatus.isTaken != true) {
        DateTime startDateAsDefault = theMedicine.startDate.toDate();
        DateTime endDateAsDefault = theMedicine.endDate.toDate();
        if (theMedicine.selectedDays == null &&
            startDateAsDefault.isBefore(DateTime.now()) &&
            endDateAsDefault.isAfter(DateTime.now())) {
          todaysMedicinesExtracted.add(theMedicine);
        } else if (startDateAsDefault.isBefore(DateTime.now()) &&
            endDateAsDefault.isAfter(DateTime.now()) &&
            theMedicine.selectedDays != null) {
          theMedicine.selectedDays!.map((element) {
            bool isToday = false;
            if (element.isFriday == true &&
                DateFormat('EEEE').format(DateTime.now()) == 'Friday') {
              isToday = true;
            } else if (element.isThursday == true &&
                DateFormat('EEEE').format(DateTime.now()) == 'Thursday') {
              isToday = true;
            } else if (element.isWednesday == true &&
                DateFormat('EEEE').format(DateTime.now()) == 'Wednesday') {
              isToday = true;
            } else if (element.isTuesday == true &&
                DateFormat('EEEE').format(DateTime.now()) == 'Tuesday') {
              isToday = true;
            } else if (element.isMonday == true &&
                DateFormat('EEEE').format(DateTime.now()) == 'Monday') {
              isToday = true;
            } else if (element.isSunday == true &&
                DateFormat('EEEE').format(DateTime.now()) == 'Sunday') {
              isToday = true;
            } else if (element.isSaturday == true &&
                DateFormat('EEEE').format(DateTime.now()) == 'Saturday') {
              isToday = true;
            }
            if (isToday) {
              todaysMedicinesExtracted.add(theMedicine);
            }
          }).toList();
        }
      }
    }
    return todaysMedicinesExtracted;
  }

  Widget TimeAndStatusRow(String time) {
    Size _screenSize = MediaQuery.of(context).size;
    String infoText = findMedicineStatusInfo(time);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.access_time),
            SizedBox(
              width: _screenSize.width * 0.03,
            ),
            Text(time),
            SizedBox(
              width: _screenSize.width * 0.03,
            ),
            Text(
              infoText,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: orange,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String findMedicineStatusInfo(String time) {
    String statusText = '';
    bool isNotTaken = false;
    List<Medicine>? medicinesOfThatTime = mappedMedicines![time];
    for (var medicine in medicinesOfThatTime!) {
      DateTime rightNow = DateTime.now();
      var currentTime = DateFormat.Hm().format(rightNow);
      if (!medicine.currentStatus.isTaken && currentTime.compareTo(time) > 0) {
        statusText = 'Is not taken';
        medicine.currentStatus.isNotTaken = true;
        medicine.currentStatus.isUnmarked = false;
      } else if (currentTime.compareTo(time) < 0) {
        statusText = 'Upcoming';
      }
    }
    return statusText;
  }
}
