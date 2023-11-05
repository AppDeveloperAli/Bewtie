// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/TabScreens/exploreScreens/exploreDetails.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/quoteScreens/requestQuote.dart';
import 'package:bewtie/TabScreens/exploreScreens/reviews.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class Search4Screen extends StatelessWidget {
  const Search4Screen({super.key});

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
                'Monday 01s August...',
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
                'Where',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your destination here...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  filled: true,
                  fillColor: Colors.white, // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const ExploreDetailsScreen()));
                      },
                      child: MyTextCard(title: 'Cancel', fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const RequestQuoteScreen()));
                        },
                        child: MyCardButton(title: 'Search')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
