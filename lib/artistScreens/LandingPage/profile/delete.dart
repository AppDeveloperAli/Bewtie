// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:flutter/material.dart';

class DeleteAccountArtist extends StatelessWidget {
  const DeleteAccountArtist({super.key});

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
                      'Delete profile',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primaryPink),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    child: Text(
                      'Are you sure you want to delete your account? You’ll lose all your data',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: MyTextCardArtist(title: 'No', fontSize: 18)),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LandingPage()));
                      },
                      child: MyCardButton(title: 'Yes'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
