// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelection.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search2.dart';
import 'package:flutter/material.dart';

class Search1Screen extends StatefulWidget {
  const Search1Screen({super.key});

  @override
  State<Search1Screen> createState() => _Search1ScreenState();
}

class _Search1ScreenState extends State<Search1Screen> {
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
                  'Which service',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  'Make-up',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              CustomCard(title: 'Bridal'),
              CustomCard(title: 'Editorial'),
              CustomCard(title: 'Film & TV'),
              CustomCard(title: 'Party'),
              CustomCard(title: 'Special Effects'),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                ),
                child: Text(
                  'Hair',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              CustomCard(title: 'Bridal'),
              CustomCard(title: 'Editorial'),
              CustomCard(title: 'Film & TV'),
              CustomCard(title: 'Party'),
              CustomCard(title: 'Special Effects'),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  'Nails',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              CustomCard(title: 'Bridal'),
              CustomCard(title: 'Editorial'),
              CustomCard(title: 'Film & TV'),
              CustomCard(title: 'Party'),
              CustomCard(title: 'Special Effects'),
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Search2Screen()));
                    },
                    child: MyCardButton(title: 'Next')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
