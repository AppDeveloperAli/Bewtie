import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:flutter/material.dart';

class EditPhoneScreen extends StatelessWidget {
  const EditPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.close),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Update your phone number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextInputFeildWidget(labelText: 'Country / region '),
                  TextInputFeildWidget(labelText: 'Phone Number'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: MyCardButton(
                title: 'Update',
              ),
            ),
          )
        ],
      )),
    );
  }
}
