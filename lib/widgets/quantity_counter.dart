import 'package:flutter/material.dart';

import 'package:flutter_medimind_app/constants.dart';

class QuantityCounter extends StatefulWidget {
  final Function setTheNumber;
  const QuantityCounter({
    Key? key,
    required this.setTheNumber,
  }) : super(key: key);

  @override
  _QuantityCounterState createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  double numberOfTablets = 1;
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    return Row(
      children: [
        IconButton(
          onPressed: () {
            decrementNumber();
            widget.setTheNumber(numberOfTablets);
          },
          icon: CircleAvatar(
            radius: 16,
            backgroundColor: bitGreyish,
            child: Icon(Icons.remove),
          ),
        ),
        SizedBox(
          width: _screenSize.width * 0.01,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: orange,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('$numberOfTablets Tablet'),
        ),
        SizedBox(
          width: _screenSize.width * 0.01,
        ),
        IconButton(
          onPressed: () {
            incrementNumber();
            widget.setTheNumber(numberOfTablets);
          },
          icon: CircleAvatar(
            radius: 16,
            backgroundColor: bitGreyish,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  void decrementNumber() {
    if (numberOfTablets > 0) {
      numberOfTablets -= 0.5;
      setState(() {});
    }
  }

  void incrementNumber() {
    numberOfTablets += 0.5;
    setState(() {});
  }
}
