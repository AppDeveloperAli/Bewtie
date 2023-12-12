// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/landingPage1.dart';
import 'package:bewtie/listsDesigns/explore_item.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );
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
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Wishlists',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              // ListView.builder(
              //   itemCount: 4,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     return ExploreItemDesign(
              //       location: '',
              //       firstName: '',
              //       lastName: '',
              //       imageLinks: [],
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
