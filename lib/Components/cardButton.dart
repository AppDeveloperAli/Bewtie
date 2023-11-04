import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class MyCardButton extends StatelessWidget {
  String title;
  MyCardButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.primaryPink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Center(
              child: Text(title,
                  style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 18))),
        ));
  }
}
