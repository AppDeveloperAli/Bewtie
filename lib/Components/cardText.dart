import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class MyTextCard extends StatelessWidget {
  String? title;
  double fontSize;
  MyTextCard({super.key, required this.title, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: Colors.black, // Outline color
            width: 1.0, // Outline width
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
              child: Text(title!,
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize))),
        ));
  }
}
