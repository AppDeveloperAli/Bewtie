// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class BookingOrdersArtist extends StatelessWidget {
  const BookingOrdersArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Service',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Price',
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 150,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        return Container(
                                          color: Colors.white,
                                          width: double.infinity,
                                          height: 400,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                    child: Container(
                                                  width: 50,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryPink,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                )),
                                                Center(
                                                    child: Text(
                                                  'Are you sure you want to cancel your booking? \n\nAs it is less than 48 hours before the  booking date, there will be a charge',
                                                  textAlign: TextAlign.center,
                                                )),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: MyCardButton(
                                                              title: 'No')),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: MyTextCard(
                                                              title: 'Yes',
                                                              fontSize: 16)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                        color: Colors.black, // Outline color
                                        width: 1.0, // Outline width
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Center(
                                          child: Text('Cancel Booking',
                                              style: TextStyle(
                                                fontFamily: 'Manrope',
                                              ))),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 150,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        return Container(
                                          color: Colors.white,
                                          width: double.infinity,
                                          height: 400,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                    child: Container(
                                                  width: 50,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryPink,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                )),
                                                Center(
                                                    child: Text(
                                                  'Have you finished the job?',
                                                  textAlign: TextAlign.center,
                                                )),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: MyCardButton(
                                                            title: 'No',
                                                          )),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: MyTextCard(
                                                              title: 'Yes',
                                                              fontSize: 16)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: MyCardButton(title: 'Job Complete'),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
