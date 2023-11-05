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
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Card(
          color: Colors.white,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: isClicked ? AppColors.primaryPink : Colors.black,
              width: 0.5,
            ),
          ),
          child: InkWell(
            onTap: toggleBorderColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  widget.title,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
