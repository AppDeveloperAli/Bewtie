// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailEditScreenArtist extends StatelessWidget {
  EmailEditScreenArtist({super.key});

  TextEditingController emailControlelr = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('Artist');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> addUser(BuildContext context) async {
    if (emailControlelr.text.isNotEmpty) {
      if (currentUser != null) {
        final DocumentReference profileDataDoc = users
            .doc(currentUser!.uid)
            .collection('Profile_Data')
            .doc(currentUser!.uid);

        final DocumentSnapshot userDoc = await profileDataDoc.get();

        if (userDoc.exists) {
          await profileDataDoc.update({
            'Email': emailControlelr.text,
          });
        } else {
          await profileDataDoc.set({
            'Email': emailControlelr.text,
          });
        }

        Navigator.pop(context);
        CustomSnackBar(context, Text('Email Updated...'));
      }
    } else {
      CustomSnackBar(context, Text("Email must be provided"));
    }
  }

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
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Update your email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Text(
                'We’ll send you an email to confirm your new email address.',
                style: TextStyle(
                  color: Colors.white,
                ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextInputFeildWidgetArtist(
                      labelText: 'Xxxxxxxxxxx',
                      controller: emailControlelr,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () async {
                  await addUser(context);
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
