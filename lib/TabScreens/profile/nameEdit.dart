// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NameEditScreen extends StatelessWidget {
  NameEditScreen({super.key});
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future<void> addUser(BuildContext context) async {
    if (firstName.text.isNotEmpty && lastName.text.isNotEmpty) {
      if (currentUser != null) {
        final DocumentSnapshot userDoc =
            await users.doc(currentUser!.uid).get();

        if (userDoc.exists) {
          await users.doc(currentUser!.uid).update({
            'first_name': firstName.text,
            'last_name': lastName.text,
          });
          Navigator.pop(context);

          CustomSnackBar(context, Text('Name Updated...'));
        } else {
          await users.doc(currentUser!.uid).set({
            'first_name': firstName.text,
            'last_name': lastName.text,
          });
          Navigator.pop(context);

          CustomSnackBar(context, Text('Name Updated...'));
        }
      }
    } else {
      CustomSnackBar(
          context, Text("Both first name and last name must be provided"));
    }
  }

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
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Update your name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextInputFeildWidget(
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
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextInputFeildWidget(
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
