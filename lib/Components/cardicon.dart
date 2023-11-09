import 'package:flutter/material.dart';

class MyCardIcon extends StatelessWidget {
  String? hintText;
  String? iconData;
  MyCardIcon({super.key, this.hintText, this.iconData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.only(left: 20),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  iconData.toString(),
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(50.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
      ),
    );
  }
}
