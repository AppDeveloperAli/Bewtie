import 'package:flutter/material.dart';

class MyCardIcon extends StatelessWidget {
  String? hintText;
  IconData? iconData;
  MyCardIcon({super.key, this.hintText, this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: 'Manrope'),
        contentPadding: const EdgeInsets.all(20),
        suffixIcon: Icon(iconData, size: 30),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(50.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
