import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCardArtist extends StatefulWidget {
  final String title;
  void Function()? onTap;
  final List<String> dataList;

  CustomCardArtist({required this.title, this.onTap, required this.dataList});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCardArtist> {
  bool isClicked = false;
  bool isDaySelected = false;

  void toggleBorderColor() {
    setState(() {
      isClicked = !isClicked;
      isDaySelected = !isDaySelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    isDaySelected = widget.dataList.contains(widget.title);
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
                //color: isClicked ? Colors.white : AppColors.primaryPink,
                color: isClicked || isDaySelected
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
                          : Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
