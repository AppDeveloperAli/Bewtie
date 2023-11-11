// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/LandingPage/booking/bookingitem.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:bewtie/listsDesigns/bookingItems.dart';
import 'package:flutter/material.dart';

class BookingScreenArtist extends StatefulWidget {
  const BookingScreenArtist({super.key});

  @override
  State<BookingScreenArtist> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreenArtist> {
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
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (route) => false,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: const [
                  Text(
                    'My bookings',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Text(
                    ' In date order',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BookingOrdersArtist();
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
