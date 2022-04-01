import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  String imagePath;
  CircularImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _ScreenSize = MediaQuery.of(context).size;

    return CircleAvatar(
      radius: _ScreenSize.height * 0.1,
      backgroundImage: AssetImage(imagePath),
    );
  }
}
