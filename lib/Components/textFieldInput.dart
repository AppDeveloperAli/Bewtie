// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextInputFeildWidget extends StatefulWidget {
  TextEditingController? controller;
  int? maxLines;
  String labelText;
  TextInputType? keyboardType;
  TextInputFeildWidget(
      {super.key,
      required this.labelText,
      this.controller,
      this.keyboardType,
      this.maxLines});

  @override
  State<TextInputFeildWidget> createState() => _TextInputFeildWidgetState();
}

class _TextInputFeildWidgetState extends State<TextInputFeildWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: const EdgeInsets.all(5),
        child: TextFormField(
          maxLength: widget.maxLines,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Will not be empty..';
            }
            return null;
          },
          controller: widget.controller,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            labelText: widget.labelText,
          ),
          keyboardType: widget.keyboardType,
          onChanged: (text) {
            setState(() {
              // email = text;
              //you can access nameController in its scope to get
              // the value of text entered as shown below
              //fullName = nameController.text;
            });
          },
        ));
  }
}
