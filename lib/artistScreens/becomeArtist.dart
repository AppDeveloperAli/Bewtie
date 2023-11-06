// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelectionArtist.dart';
import 'package:bewtie/artistScreens/becomeArtist2.dart';
import 'package:flutter/material.dart';

class BecomeArtistScreen extends StatefulWidget {
  const BecomeArtistScreen({super.key});

  @override
  State<BecomeArtistScreen> createState() => _Search1ScreenState();
}

class _Search1ScreenState extends State<BecomeArtistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'What do you do?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  'Mack-up',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomCardArtist(title: 'Bridal'),
              CustomCardArtist(title: 'Editorial'),
              CustomCardArtist(title: 'Film & Tv'),
              CustomCardArtist(title: 'Party'),
              CustomCardArtist(title: 'Special Effects'),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  'Hair',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomCardArtist(title: 'Bridal'),
              CustomCardArtist(title: 'Editorial'),
              CustomCardArtist(title: 'Film & Tv'),
              CustomCardArtist(title: 'Party'),
              CustomCardArtist(title: 'Special Effects'),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  'Nails',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomCardArtist(title: 'Bridal'),
              CustomCardArtist(title: 'Editorial'),
              CustomCardArtist(title: 'Film & Tv'),
              CustomCardArtist(title: 'Party'),
              CustomCardArtist(title: 'Special Effects'),
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BecomeArtistScreen2()));
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