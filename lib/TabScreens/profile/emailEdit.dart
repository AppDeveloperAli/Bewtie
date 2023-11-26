// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailEditScreen extends StatelessWidget {
  EmailEditScreen({super.key});

  TextEditingController emailController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future<void> addUser(BuildContext context) async {
    if (emailController.text.isNotEmpty) {
      if (currentUser != null) {
        final DocumentSnapshot userDoc =
            await users.doc(currentUser!.uid).get();

        if (userDoc.exists) {
          await users.doc(currentUser!.uid).update({
            'email': emailController.text,
          });
          Navigator.pop(context);
          CustomSnackBar(context, Text('Name Updated...'));
        } else {
          await users.doc(currentUser!.uid).set({
            'email': emailController.text,
          });
          Navigator.pop(context);
          CustomSnackBar(context, Text('Name Updated...'));
        }
      }
    } else {
      CustomSnackBar(context, Text("Email must be provided..."));
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
                    child: TextInputFeildWidget(
                      labelText: 'Xxxxxxxxxxx',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () async {
                  await addUser(context); // Navigator.pop(context);
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
