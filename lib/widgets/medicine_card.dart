import 'package:flutter/material.dart';

import 'package:flutter_medimind_app/constants.dart';
import 'package:flutter_medimind_app/models/medicine.dart';
import 'package:flutter_medimind_app/services/anonymous_auth_service.dart';
import 'package:flutter_medimind_app/services/firestore_service.dart';
import 'package:provider/provider.dart';

class MedicineCard extends StatelessWidget {
  Medicine medicine;
  String time;

  MedicineCard({required this.medicine, required this.time});

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset('assets/images/capsules.png'),
      ),
      title: Text(
        medicine.name,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(
        medicine.dosage.toString(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size(10, 30)),
        child: Icon(Icons.check),
        onPressed: () {
          String? patientUID =
              Provider.of<AnonymousAuthService>(context, listen: false).uid;
          Provider.of<FireStoreService>(context, listen: false)
              .takeMedicine(patientUID!, medicine.id, time);
        },
      ),
    );
  }
}
