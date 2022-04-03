import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/config.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/models/patient_user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../models/event.dart';
import '../../models/medicine.dart';
import '../../services/anonymous_auth_service.dart';
import 'package:flutter_medimind_app/services/firestore_service.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  String? _patientUid;

  FireStoreService? firestoreService;

  Future<PatientUser>? patient;

  LinkedHashMap<DateTime, List<Event>> kMedicineEvents = LinkedHashMap<DateTime, List<Event>>();

  @override
  void initState() {
    super.initState();

    firestoreService = Provider.of<FireStoreService>(context,listen: false);

    _patientUid = Provider.of<AnonymousAuthService>(
        context,
        listen: false)
        .uid!;
    patient = firestoreService!.getThePatientOnce(_patientUid ?? '');

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    medicineEventsAll(DateTime.now().subtract(Duration(days: 365)), DateTime.now().add(Duration(days: 365)));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kMedicineEvents[day] ?? [];
  }



  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  bool isSameDate(DateTime one, DateTime other) {
    return one.year == other.year && one.month == other.month
        && one.day == other.day;
  }


  medicineEventsAll(DateTime start, DateTime end) {
    List<DateTime> days = daysInRange(start, end);


    LinkedHashMap<DateTime, List<Event>> eventMap =
    LinkedHashMap<DateTime, List<Event>>();

    for (final d in days) {
      eventMap[d] = [];
    }



    List<Medicine> medicinesList;
    patient?.then((patient) {
      medicinesList = patient.medicinesList;
      for (var medicine in medicinesList) {
        DateTime startDate = medicine.startDate.toDate();
        DateTime endDate = medicine.endDate.toDate();
        if(endDate.isBefore(end) && start.isBefore(startDate)) {
          List<DateTime> medicineDays = daysInRange(startDate, endDate);
          eventMap.keys.forEach((calendarDate) {
            medicineDays.forEach((medicineDate) {
              if(isSameDate(calendarDate, medicineDate)) {
                if(medicine.frequency.isDaily) {
                  var events = eventMap[calendarDate];
                  events?.add(Event(medicine.name + ' ' + medicine.dosage
                      .toString() + ' at ' + medicine.reminderTimes.first));
                } else if(medicine.frequency.isSpecificDays){
                  var day = DateFormat('E').format(medicineDate);
                  if(medicine.toMap()['is' + day + 'Selected']) {
                    var events = eventMap[calendarDate];
                    events?.add(Event(medicine.name + ' ' + medicine.dosage
                        .toString() + ' at ' + medicine.reminderTimes.first));
                  }
                }
              }

            });


          });

        }
      }

      // kMedicineEvents = LinkedHashMap<DateTime, List<Event>>(
      //   equals: isSameDay,
      //   hashCode: getHashCode,
      // )..addAll(eventMap)
      setState(() => kMedicineEvents = LinkedHashMap<DateTime, List<Event>>(
        equals: isSameDay,
        hashCode: getHashCode,
      )..addAll(eventMap));

    });



  }






  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),

      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

