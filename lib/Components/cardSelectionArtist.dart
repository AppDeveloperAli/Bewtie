import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCardArtist extends StatefulWidget {
  final String title;

  CustomCardArtist({required this.title});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCardArtist> {
  bool isClicked = false;

  void toggleBorderColor() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleBorderColor,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: isClicked ? AppColors.primaryPink : Colors.white,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: isClicked ? AppColors.primaryPink : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
