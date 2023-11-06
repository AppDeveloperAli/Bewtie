import 'package:flutter/material.dart';

class TextInputFeildWidgetArtist extends StatefulWidget {
  TextEditingController? controller;
  String labelText;
  TextInputFeildWidgetArtist(
      {super.key, required this.labelText, this.controller});

  @override
  State<TextInputFeildWidgetArtist> createState() =>
      _TextInputFeildWidgetState();
}

class _TextInputFeildWidgetState extends State<TextInputFeildWidgetArtist> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: const EdgeInsets.all(5),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Will not be empty..';
            }
            return null;
          },
          controller: widget.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white), // Outline color
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(color: Colors.white), // Label text color
          ),
          style: TextStyle(color: Colors.white),
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
