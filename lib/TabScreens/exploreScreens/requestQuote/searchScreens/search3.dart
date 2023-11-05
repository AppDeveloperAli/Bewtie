// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search4.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search3Screen extends StatefulWidget {
  const Search3Screen({super.key});

  @override
  State<Search3Screen> createState() => _Search3ScreenState();
}

class _Search3ScreenState extends State<Search3Screen> {
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
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.close,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Mack-up (Bridal)...',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.primaryPink,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Mack-up (€0)...',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.primaryPink,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'When',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                onDateTimeChanged: (dateTime) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Search4Screen()));
                  },
                  child: MyCardButton(title: 'Next')),
            )
          ],
        ),
      ),
    );
  }
}
