import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String imagePath;
  const ShowImage(this.imagePath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 300,
          color: Colors.white,
          child: InteractiveViewer(
            scaleFactor: 300,
            child: Image.asset(imagePath),
          ),
      ),
    );
  }
}
