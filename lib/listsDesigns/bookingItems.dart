// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class BookingOrders extends StatelessWidget {
  const BookingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: AppColors.primaryPink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
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
                                return SizedBox(
                                  width: double.infinity,
                                  height: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 100,
                                            height: 0.5,
                                            color: AppColors.primaryPink,
                                          ),
                                        ),
                                        Center(
                                            child: Text(
                                          'Are you sure you want to cancel your booking with XXXXXXXXX?\n\n Cancellation charges apply',
                                          textAlign: TextAlign.center,
                                        )),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: MyCardButton(
                                                      title: 'No')),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: MyTextCard(
                                                      title: 'Yes',
                                                      fontSize: 18)),
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
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
