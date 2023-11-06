// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/LandingPage/booking/bookingitem.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'My bookings In date order',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
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
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return BookingOrdersArtist();
              },
            )
          ],
        ),
      )),
    );
  }
}
