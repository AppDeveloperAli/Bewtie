// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/quoteScreens/requestQuote.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/LandingPage/mainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BecomeArtistScreen4 extends StatefulWidget {
  // From 1st Screen :-
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;

  // From 2nd Screen :-
  final int priceMakeup;
  final int priceHair;
  final int priceNails;

  // From 3rd Screen :-
  final List<String> availability;

  const BecomeArtistScreen4(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails,
      required this.priceMakeup,
      required this.priceHair,
      required this.priceNails,
      required this.availability});

  @override
  State<BecomeArtistScreen4> createState() => _BecomeArtistScreen4State();
}

class _BecomeArtistScreen4State extends State<BecomeArtistScreen4> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _location = TextEditingController();

  // Function to create firebase collection :-

  void _createArtistCollection(String location) async {
    final CollectionReference artistsCollection =
        _firestore.collection('Artist');

    // Check if the collection already exists
    if (!(await artistsCollection.doc().get()).exists) {
      // Collection doesn't exist, create it
      await artistsCollection.doc().set({
        'Makeup Type': widget.typeMakeup, // Example makeup types
        'availability': widget.availability, // Example availability
        'Location': location.toString(),
        'price': widget.priceMakeup,
      });

      print('Artist collection created successfully.');
    } else {
      print('Artist collection already exists.');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("--------${widget.typeMakeup}");
    print("--------${widget.priceMakeup}");
    print("--------${widget.availability}");
    return Scaffold(
      backgroundColor: Colors.black,
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
                        'Make-up (Bridal)...',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Make-up (€0)...',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Monday 01s August...',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Your Location',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.primaryPink,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextInputFeildWidgetArtist(
                          labelText: 'Enter your destination here...',
                          controller: _location,
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ArtistMainPage()));
                          },
                          child: GestureDetector(
                              onTap: () {
                                setState(() {});
                                print("---------Submit");
                                _createArtistCollection(_location.text);
                              },
                              child: MyCardButton(title: 'Submit'))),
                    ),
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
