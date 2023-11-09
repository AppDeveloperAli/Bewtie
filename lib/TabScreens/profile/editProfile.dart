import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:flutter/material.dart';

class EditPhoneScreenArtist extends StatelessWidget {
  const EditPhoneScreenArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Update your phone number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextInputFeildWidgetArtist(labelText: 'Country / region '),
                  TextInputFeildWidgetArtist(labelText: 'Phone Number'),
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
