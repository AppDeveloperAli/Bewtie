import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String title;

  CustomCard({required this.title});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isClicked = false;

  void toggleBorderColor() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: isClicked ? AppColors.primaryPink : Colors.black,
              width: 0.5,
            ),
          ),
          child: GestureDetector(
            onTap: toggleBorderColor,
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: isClicked ? AppColors.primaryPink : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
