// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bewtie/TabScreens/profile/editPhone.dart';
import 'package:bewtie/TabScreens/profile/editPhoto.dart';
import 'package:bewtie/TabScreens/profile/emailEdit.dart';
import 'package:bewtie/TabScreens/profile/nameEdit.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  late String firstName = "";
  late String lastName = "";
  late String email = "";
  late String number = "";
  late String image = "";

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      getUserData(currentUser!.uid);
    }
  }

  Future<void> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        setState(() {
          firstName = userData['first_name'] ?? "Artist Name";
          lastName = userData['last_name'] ?? "";
          email = userData['email'] ?? "Email Address";
          number = userData['number'] ?? "Phone Number";
          image = userData['profileimage'] ?? "";
        });
      } else {
        print("User document does not exist");
      }
    } catch (e) {
      print("Error fetching user data: $e");
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
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Edit personal information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditPhoto()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: double.infinity,
                height: 0.5,
                color: AppColors.lightPink,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    '${firstName} ${lastName}',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NameEditScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: double.infinity,
                height: 0.5,
                color: AppColors.lightPink,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    '$email',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmailEditScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: double.infinity,
                height: 0.5,
                color: AppColors.lightPink,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'Phone Number',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    '$number',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditPhoneScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: double.infinity,
                height: 0.5,
                color: AppColors.lightPink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
