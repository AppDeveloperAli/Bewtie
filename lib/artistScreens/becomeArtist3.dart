// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelectionArtist.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search4.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/becomeArtist4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BecomeArtist3 extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;
  final int priceMakeup;
  final int priceHair;
  final int priceNails;
  const BecomeArtist3(
      {super.key,
      required this.priceMakeup,
      required this.priceHair,
      required this.priceNails,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails});

  @override
  State<BecomeArtist3> createState() => _Search3ScreenState();
}

class _Search3ScreenState extends State<BecomeArtist3> {
  final List<String> availability = [];
  @override
  Widget build(BuildContext context) {
    print("----------${widget.typeMakeup}");
    print("------${widget.priceMakeup}");
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
                      'Your availibilty',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomCardArtist(
                    title: 'Mon',
                    onTap: () {
                      if (availability.contains("Mon")) {
                        availability.remove("Mon");
                      } else {
                        availability.add("Mon");
                      }
                      setState(() {});
                    },
                  ),
                  CustomCardArtist(
                    title: 'Tue',
                    onTap: () {
                      if (availability.contains("Tue")) {
                        availability.remove("Tue");
                      } else {
                        availability.add("Tue");
                      }
                      setState(() {});
                    },
                  ),
                  CustomCardArtist(
                    title: 'Wed',
                    onTap: () {
                      if (availability.contains("Wed")) {
                        availability.remove("Wed");
                      } else {
                        availability.add("Wed");
                      }
                      setState(() {});
                    },
                  ),
                  CustomCardArtist(
                    title: 'Thu',
                    onTap: () {
                      if (availability.contains("Thu")) {
                        availability.remove("Thu");
                      } else {
                        availability.add("Thu");
                      }
                      setState(() {});
                    },
                  ),
                  CustomCardArtist(
                    title: 'Fri',
                    onTap: () {
                      if (availability.contains("Fri")) {
                        availability.remove("Fri");
                      } else {
                        availability.add("Fri");
                      }
                      setState(() {});
                    },
                  ),
                  CustomCardArtist(
                    title: 'Sat',
                    onTap: () {
                      if (availability.contains("Sat")) {
                        availability.remove("Sat");
                      } else {
                        availability.add("Sat");
                      }
                      setState(() {});
                    },
                  ),
                  CustomCardArtist(
                    title: 'Sun',
                    onTap: () {
                      if (availability.contains("Sun")) {
                        availability.remove("Sun");
                      } else {
                        availability.add("Sun");
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    print("---------$availability");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BecomeArtistScreen4(
                              typeMakeup: widget.typeMakeup,
                              typeHair: widget.typeHair,
                              typeNails: widget.typeNails,
                              priceMakeup: widget.priceMakeup,
                              priceHair: widget.priceHair,
                              priceNails: widget.priceNails,
                              availability: availability,
                            )));
                  },
                  child: MyCardButton(title: 'Next')),
            )
          ],
        ),
      ),
    );
  }
}
