import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/config.dart';
import 'package:flutter_medimind_app/constants.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../models/event.dart';

// class UpcomingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Pill Calendar"),
//         centerTitle: true,
//       ),
//       body: TableCalendar(
//         focusedDay: DateTime.now(),
//         firstDay: DateTime(1990),
//         lastDay: DateTime(2050))
//     );
//   }
// }


class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {

  Map<DateTime,List<Event>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [Event(title: 'test')];
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("My Pill Calendar"),
          centerTitle: true,
        ),
        body: Column(
          children: [
      TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
          },
          startingDayOfWeek: StartingDayOfWeek.sunday,
          daysOfWeekVisible: true,
          // Code for day changes
          onDaySelected: (DateTime selectDay,DateTime focusDay) {
            setState(() {
              selectedDay = selectDay;
              focusedDay = focusDay;
            });
          },
          selectedDayPredicate: (DateTime date){
            return isSameDay(selectedDay, date);
          },
            //Styling components of calendar
              calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                shape: BoxShape.circle,
                  ),
              ),
          headerStyle:  HeaderStyle(
            formatButtonVisible: true,
            titleCentered: true,
            formatButtonShowsNext: false,
            formatButtonDecoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5.0),
            ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              )
          ),

        ),
            ..._getEventsfromDay(selectedDay).map(
                  (Event event) => ListTile(
                title: Text(
                  event.title,
                ),
              ),
            ),
    ]));
  }
}
