// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NameEditScreenArtist extends StatelessWidget {
  NameEditScreenArtist({super.key});
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('Artist');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> addUser(BuildContext context) async {
    if (firstName.text.isNotEmpty && lastName.text.isNotEmpty) {
      if (currentUser != null) {
        final DocumentReference profileDataDoc = users
            .doc(currentUser!.uid)
            .collection('Profile_Data')
            .doc(currentUser!.uid);

        final DocumentSnapshot userDoc = await profileDataDoc.get();

        if (userDoc.exists) {
          await profileDataDoc.update({
            'first_name': firstName.text,
            'last_name': lastName.text,
          });
        } else {
          await profileDataDoc.set({
            'first_name': firstName.text,
            'last_name': lastName.text,
          });
        }

        Navigator.pop(context);
        CustomSnackBar(context, Text('Name Updated...'));
      }
    } else {
      CustomSnackBar(
          context, Text("Both first name and last name must be provided"));
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
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Update your ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 15),
                      child: Text(
                        'First name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextInputFeildWidgetArtist(
                        labelText: 'Xxxxxxxxxxx',
                        controller: firstName,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 15),
                      child: Text(
                        'Last name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextInputFeildWidgetArtist(
                        labelText: 'Xxxxxxxxxxx',
                        controller: lastName,
                      ),
                    )
                  ],
                ),
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
