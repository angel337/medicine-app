import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/models/frequencyType.dart';
import 'package:flutter_medimind_app/models/medicine.dart';
import 'package:flutter_medimind_app/models/status.dart';
import 'package:flutter_medimind_app/screens/patientScreens/bottom_nav_handler.dart';
import 'package:flutter_medimind_app/services/anonymous_auth_service.dart';
import 'package:flutter_medimind_app/services/firestore_service.dart';
import 'package:flutter_medimind_app/widgets/quantity_counter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

enum options { daily, onSpecificDays }

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  TextEditingController medicineNameController = TextEditingController();
  TextEditingController durationNumberController = TextEditingController();
  List<TimeOfDay> reminders = [];
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isSatSelected = false;
  bool isSunSelected = false;
  bool isMonSelected = false;
  bool isTueSelected = false;
  bool isWedSelected = false;
  bool isThuSelected = false;
  bool isFriSelected = false;
  options radioButtonValue = options.daily;
  String dropdownValue = 'Days';
  DateTime? _selectedDate;
  double numberOfTablets = 1;
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 1,
        title: Text(
          'New Medicine',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: orange,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(_screenSize.height * 0.03),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Name of medicine',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _screenSize.height * 0.02,
                ),
                Form(
                  child: TextFormField(
                    controller: medicineNameController,
                    decoration: InputDecoration(
                        hintText: 'New Medicine Name',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: greyishColor),
                        fillColor: smallbitGreyish,
                        filled: true),
                  ),
                ),
                SizedBox(
                  height: _screenSize.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dosage',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    QuantityCounter(
                      setTheNumber: setTheNumberOfTablets,
                    ),
                  ],
                ),
                SizedBox(
                  height: _screenSize.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Date',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Container(
                      height: _screenSize.height * 0.06,
                      // padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(color: orange),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              _selectedDate == null
                                  ? 'Please choose a date'
                                  : '${DateFormat.yMd().format(_selectedDate!)}',
                            ),
                          ),
                          IconButton(
                            onPressed: _presentDataPicker,
                            icon: Icon(
                              Icons.calendar_today,
                              color: orange,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _screenSize.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Duration',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 33,
                          width: 33,
                          // padding: EdgeInsets.all(),
                          decoration: BoxDecoration(
                            border: Border.all(color: orange),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Form(
                            child: TextFormField(
                              controller: durationNumberController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: '1',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: greyishColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: _screenSize.height * 0.02,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: blackColor,
                          ),
                          iconSize: 20,
                          elevation: 16,
                          style: const TextStyle(color: orange),
                          underline: Container(
                            height: 2,
                            color: orange,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            'Days',
                            'Weeks',
                            'Months',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: _screenSize.height * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      'Frequency',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Divider(
                  color: blackColor,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: _screenSize.height * 0.05,
                      child: ListTile(
                        title: const Text('Daily'),
                        leading: Radio<options>(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: options.daily,
                          groupValue: radioButtonValue,
                          onChanged: (options? value) {
                            setState(() {
                              radioButtonValue = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: _screenSize.height * 0.05,
                      child: ListTile(
                        title: const Text('On Specific Days'),
                        leading: Radio<options>(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: options.onSpecificDays,
                          groupValue: radioButtonValue,
                          onChanged: (options? value) {
                            setState(() {
                              radioButtonValue = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _screenSize.height * 0.03,
                ),
                if (radioButtonValue == options.onSpecificDays)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 34,
                        width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: orange),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ChoiceChip(
                          backgroundColor: whiteColor,
                          onSelected: (value) => setState(() {
                            isSunSelected = value;
                          }),
                          label: Text('S'),
                          selected: isSunSelected,
                        ),
                      ),
                      Container(
                        height: 34,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: orange),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ChoiceChip(
                          backgroundColor: whiteColor,
                          onSelected: (value) => setState(() {
                            isMonSelected = value;
                          }),
                          label: Text('M'),
                          selected: isMonSelected,
                        ),
                      ),
                      Container(
                        height: 34,
                        width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: orange),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ChoiceChip(
                          backgroundColor: whiteColor,
                          onSelected: (value) => setState(() {
                            isTueSelected = value;
                          }),
                          label: Text('T'),
                          selected: isTueSelected,
                        ),
                      ),
                      Container(
                        height: 34,
                        width: 41,
                        decoration: BoxDecoration(
                          border: Border.all(color: orange),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ChoiceChip(
                          backgroundColor: whiteColor,
                          onSelected: (value) => setState(() {
                            isWedSelected = value;
                          }),
                          label: Text('W'),
                          selected: isWedSelected,
                        ),
                      ),
                      Container(
                        height: 34,
                        width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: orange),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ChoiceChip(
                          backgroundColor: whiteColor,
                          onSelected: (value) => setState(() {
                            isThuSelected = value;
                          }),
                          label: Text('T'),
                          selected: isThuSelected,
                        ),
                      ),
                      Container(
                        height: 34,
                        width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: orange),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ChoiceChip(
                          backgroundColor: whiteColor,
                          onSelected: (value) => setState(() {
                            isFriSelected = value;
                          }),
                          label: Text('F'),
                          selected: isFriSelected,
                        ),
                      ),
                      Container(
                        height: 34,
                        width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: orange),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ChoiceChip(
                          backgroundColor: whiteColor,
                          onSelected: (value) => setState(() {
                            isSatSelected = value;
                          }),
                          label: Text('S'),
                          selected: isSatSelected,
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: _screenSize.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select time',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    RawMaterialButton(
                      onPressed: () async {
                        await showTimePicker(
                          initialTime: selectedTime,
                          context: context,
                          builder: (context, theChild) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: theChild!,
                            );
                          },
                        ).then((value) {
                          if (value != null) {
                            selectedTime = value;
                            reminders.add(value);
                            setState(() {});
                          }
                        });
                      },
                      elevation: 2.0,
                      fillColor: orange,
                      child: Icon(
                        Icons.add,
                        size: 20.0,
                        color: whiteColor,
                      ),
                      // padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    )
                  ],
                ),
                SizedBox(
                  height: _screenSize.height * 0.02,
                ),
                Container(
                  height: _screenSize.height * 0.15,
                  width: _screenSize.width * 0.7,
                  child: ListView.builder(
                      itemCount: reminders.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          height: _screenSize.height * 0.03,
                          decoration: BoxDecoration(
                            border: Border.all(color: orange),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text(
                              reminders[index].format(context),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      DateTime rightNow = DateTime.now();
                      // duration depending on dropDownValue:
                      DateTime endingDate;
                      int durationNum =
                          int.parse(durationNumberController.text);
                      if (dropdownValue == 'Months') {
                        endingDate = DateTime(rightNow.year,
                            rightNow.month + durationNum, rightNow.day);
                      } else if (dropdownValue == 'Days') {
                        endingDate = DateTime(rightNow.year, rightNow.month,
                            rightNow.day + durationNum);
                      } else {
                        endingDate = DateTime(rightNow.year, rightNow.month,
                            rightNow.day + (durationNum * 7));
                      }
                      List<String> allRemindersAsString = [];
                      for (var reminder in reminders) {
                        var reminderAsString24Hour = to24hours(reminder);

                        allRemindersAsString.add(reminderAsString24Hour);
                      }
                      var uuid = Uuid();
                      String? userUID = Provider.of<AnonymousAuthService>(
                              context,
                              listen: false)
                          .uid;
                      Timestamp startDateAsTimeStamp =
                          Timestamp.fromDate(_selectedDate!); //To TimeStamp
                      Timestamp endDateAsTimeStamp =
                          Timestamp.fromDate(endingDate); //To TimeStamp

                      if (medicineNameController.text.isNotEmpty &&
                          _selectedDate != null &&
                          durationNumberController.text.isNotEmpty &&
                          reminders.isNotEmpty) {
                        Medicine theMedicine = Medicine(
                          id: uuid.v4(),
                          name: medicineNameController.text,
                          dosage: numberOfTablets,
                          startDate: startDateAsTimeStamp,
                          endDate: endDateAsTimeStamp,
                          frequency: FrequencyType(
                              isDaily: (radioButtonValue == options.daily),
                              isSpecificDays:
                                  (radioButtonValue == options.onSpecificDays)),
                          reminderTimes: allRemindersAsString,
                          currentStatus: Status(),
                        );
                        Provider.of<FireStoreService>(context, listen: false)
                            .addMedicineToFirestore(userUID!, theMedicine);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Medicine added successfully"),
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Failed to add the medicine, please fill in all the blanks."),
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Add',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: orange,
                      minimumSize: Size(
                          _screenSize.width * 0.8, _screenSize.height * 0.05),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String to24hours(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, "0");
    final min = timeOfDay.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }

  void _presentDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  setTheNumberOfTablets(double number) {
    this.numberOfTablets = number;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    reminders = [];
  }
}
