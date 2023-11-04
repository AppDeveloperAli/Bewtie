import 'package:flutter/material.dart';

class ClickableText extends StatefulWidget {
  final String text;

  ClickableText({required this.text});

  @override
  _ClickableTextState createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  bool isBold = false;

  void toggleBold() {
    setState(() {
      isBold = !isBold;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleBold,
      child: RichText(
        text: TextSpan(
          text: widget.text,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black),
        ),
      ),
    );
  }
}
