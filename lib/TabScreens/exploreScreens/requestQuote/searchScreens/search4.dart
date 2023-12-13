// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/TabScreens/exploreScreens/exploreDetails.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:flutter/material.dart';

class Search4Screen extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;
  final Map<String, double> makeupPrices;
  final Map<String, double> hairPrices;
  final Map<String, double> nailsPrices;
  final DateTime dateTime;

  Search4Screen(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails,
      required this.makeupPrices,
      required this.hairPrices,
      required this.nailsPrices,
      required this.dateTime});

  @override
  State<Search4Screen> createState() => _Search4ScreenState();
}

class _Search4ScreenState extends State<Search4Screen> {
  @override
  Widget build(BuildContext context) {
    print("-------${widget.typeMakeup}");
    print("-------${widget.typeHair}");
    print("-------${widget.typeNails}");
    print("-------${widget.hairPrices}");
    print("-------${widget.nailsPrices}");
    print("-------${widget.makeupPrices}");
    print("-------${widget.dateTime}");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.close, size: 40),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Make-up (Bridal)...',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: AppColors.lightPink,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Make-up (€0)...',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: AppColors.lightPink,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Monday 01 August...',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: AppColors.lightPink,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Where',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your destination here...',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LandingPage()));
                      },
                      child: MyTextCard(title: 'Cancel', fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LandingPage()));
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
