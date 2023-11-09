// ignore_for_file: prefer_const_constructors

import 'package:bewtie/TabScreens/profile/editPhone.dart';
import 'package:bewtie/TabScreens/profile/editPhoto.dart';
import 'package:bewtie/TabScreens/profile/emailEdit.dart';
import 'package:bewtie/TabScreens/profile/nameEdit.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

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
                    'Name',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NameEditScreen()));
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
                    'Email address',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EmailEditScreen()));
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
                    '00000 00000',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditPhoneScreen()));
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
