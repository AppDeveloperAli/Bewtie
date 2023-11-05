import 'package:flutter/material.dart';

class TextInputFeildWidget extends StatefulWidget {
  TextEditingController? controller;
  String labelText;
  TextInputFeildWidget({super.key, required this.labelText, this.controller});

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
          validator: (value) {
            if (value!.isEmpty) {
              return 'Will not be empty..';
            }
            return null;
          },
          controller: widget.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: widget.labelText,
          ),
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
