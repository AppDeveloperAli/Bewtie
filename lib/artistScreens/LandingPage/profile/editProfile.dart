// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Utils/snackBar.dart';
import 'package:bewtie/artistScreens/LandingPage/profile/EditPersonalInfo/editPhone.dart';
import 'package:bewtie/artistScreens/LandingPage/profile/EditPersonalInfo/editName.dart';
import 'package:bewtie/artistScreens/LandingPage/profile/EditPersonalInfo/editPhoto.dart';
import 'package:bewtie/artistScreens/LandingPage/profile/EditPersonalInfo/emailEdit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalInformationArtist extends StatefulWidget {
  PersonalInformationArtist({super.key});

  @override
  State<PersonalInformationArtist> createState() =>
      _PersonalInformationArtistState();
}

class _PersonalInformationArtistState extends State<PersonalInformationArtist> {
  CollectionReference users = FirebaseFirestore.instance.collection('Artist');

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
      getUserData();
    }
  }

  Future<void> getUserData() async {
    try {
      final DocumentReference profileDataDoc = users
          .doc(currentUser!.uid)
          .collection('Profile_Data')
          .doc(currentUser!.uid);

      final DocumentSnapshot userDoc = await profileDataDoc.get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        setState(() {
          firstName = userData['first_name'] ?? "Name";
          lastName = userData['last_name'] ?? "";
          email = userData['Email'] ?? "Email Address";
          number = userData['number'] ?? "Phone Number";
          image = userData['profileimage'] ?? "";
        });
      } else {
        CustomSnackBar(context, Text('User Data not available'));
      }
    } catch (e) {
      CustomSnackBar(context, Text('Error fetching user data: $e'));
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
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Edit personal information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
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
                        builder: (context) => const EditPhotoArtist()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontFamily: 'Manrope'),
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
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    firstName,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NameEditScreenArtist()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
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
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    email,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmailEditScreenArtist()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
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
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'Phone Number',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditPhoneScreenArtist()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
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
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
