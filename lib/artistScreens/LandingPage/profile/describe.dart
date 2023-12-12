// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DescribeScreen extends StatefulWidget {
  const DescribeScreen({super.key});

  @override
  State<DescribeScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<DescribeScreen> {
  TextEditingController controller = TextEditingController();

  CollectionReference users =
      FirebaseFirestore.instance.collection('Artist_Data');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> addUser(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      if (currentUser != null) {
        final DocumentReference profileDataDoc = users.doc(currentUser!.uid);

        final DocumentSnapshot userDoc = await profileDataDoc.get();

        if (userDoc.exists) {
          await profileDataDoc.update({
            'describe': controller.text,
          });
        } else {
          await profileDataDoc.set({
            'describe': controller.text,
          });
        }

        Navigator.pop(context);
        CustomSnackBar(context, Text('Describe Updated...'));
      }
    } else {
      CustomSnackBar(context, Text("Describe must be provided"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Describe yourself',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: controller,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Start typing...',
                        hintStyle: TextStyle(color: Colors.white),
                        helperStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      maxLines: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            MyTextCardArtist(title: 'Cancel', fontSize: 18))),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          addUser(context);
                        },
                        child: MyCardButton(title: 'Send'))),
              ],
            ),
          )
        ],
      )),
    );
  }
}
