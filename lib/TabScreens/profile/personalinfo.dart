import 'dart:async';

import 'package:bewtie/TabScreens/profile/editPhone.dart';
import 'package:bewtie/TabScreens/profile/editPhoto.dart';
import 'package:bewtie/TabScreens/profile/emailEdit.dart';
import 'package:bewtie/TabScreens/profile/nameEdit.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: SnackBar(content: Text('User Data not available')),
          );
        }

        Map<String, dynamic> userData =
            snapshot.data!.data() as Map<String, dynamic>;

        return PersonalInformationWidget(userData: userData);
      },
    );
  }
}

class PersonalInformationWidget extends StatelessWidget {
  final Map<String, dynamic> userData;

  const PersonalInformationWidget({Key? key, required this.userData})
      : super(key: key);

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
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
            ),
            const Padding(
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
                        image: NetworkImage(userData['profileimage'] ?? ""),
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
                  child: const Padding(
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
            const Padding(
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
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NameEditScreen()));
                  },
                  child: const Padding(
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
            const Padding(
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
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '${userData['email'] ?? ''}',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmailEditScreen()));
                  },
                  child: const Padding(
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
            const Padding(
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
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '${userData['number'] ?? ''}',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditPhoneScreen()));
                  },
                  child: const Padding(
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
