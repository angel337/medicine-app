import 'package:flutter/material.dart';
import 'package:flutter_medimind_app/config.dart';
import 'package:flutter_medimind_app/models/caretaker_user.dart';
import 'package:flutter_medimind_app/services/authentication_service.dart';
import 'package:flutter_medimind_app/services/firestore_service.dart';
import 'package:flutter_medimind_app/widgets/caretaker_invited_screen.dart';
import 'package:flutter_medimind_app/widgets/caretaker_not_invited_screen.dart';
import 'package:provider/provider.dart';

class caretakerInvitationScreen extends StatefulWidget {
  const caretakerInvitationScreen({Key? key}) : super(key: key);

  @override
  State<caretakerInvitationScreen> createState() =>
      _caretakerInvitationScreenState();
}

class _caretakerInvitationScreenState extends State<caretakerInvitationScreen> {
  @override
  Widget build(BuildContext context) {
    // Provider.of<AuthService>(context, listen: false).signOut();
    var caretakerUID =
        Provider.of<AuthService>(context, listen: false).user!.uid;
    var caretakerModel = Provider.of<FireStoreService>(context, listen: false)
        .getCaretaker(caretakerUID);

    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<CaretakerUser>(
          future: Provider.of<FireStoreService>(context, listen: false)
              .getCaretaker(caretakerUID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            }
            if (snapshot.data!.trackedPatients.isEmpty) {
              return CaretakerNotInvited();
            }
            if (snapshot.data!.trackedPatients.isEmpty) {}
            return CaretakerInvited(theCaretakerUser: caretakerModel);
          },
        ));
  }
}
