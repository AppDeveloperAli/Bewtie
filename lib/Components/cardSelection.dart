import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String title;
  void Function()? onTap;

  CustomCard({required this.title, this.onTap});

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
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        toggleBorderColor();
      },
      child: SizedBox(
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
