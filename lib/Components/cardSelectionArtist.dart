import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCardArtist extends StatefulWidget {
  final String title;
  void Function()? onTap;
  final List<String> dataList;
  late bool isHighlighted;

  CustomCardArtist({
    required this.title,
    this.onTap,
    required this.dataList,
    this.isHighlighted = false,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCardArtist> {
  bool isClicked = false;
  bool isDaySelected = false;

  @override
  Widget build(BuildContext context) {
    isDaySelected =
        widget.dataList.contains(widget.title) || widget.isHighlighted;

    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        toggleBorderColor();
      },
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
                color: isClicked || widget.isHighlighted
                    ? AppColors.primaryPink
                    : Colors.white,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: isClicked || isDaySelected
                        ? AppColors.primaryPink
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggleBorderColor() {
    setState(() {
      isClicked = !isClicked;
      isDaySelected = !isDaySelected;
      widget.isHighlighted = !widget.isHighlighted;
    });
  }
}
