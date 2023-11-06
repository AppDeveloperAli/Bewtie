// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:flutter/material.dart';

class EmailEditScreen extends StatelessWidget {
  const EmailEditScreen({super.key});

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
                'Update your email',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Text(
                'We’ll send you an email to confirm your new email address.',
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 15),
                    child: Text(
                      'Email',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextInputFeildWidget(labelText: 'Xxxxxxxxxxx'),
                  ),
                ],
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
        ),
      ),
    );
  }
}
