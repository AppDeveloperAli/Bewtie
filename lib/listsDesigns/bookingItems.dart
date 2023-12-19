// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingOrders extends StatefulWidget {
  String? date, name, service, location, price, orderID, artName;
  BookingOrders(
      {super.key,
      required this.date,
      required this.location,
      required this.name,
      required this.artName,
      required this.price,
      required this.orderID,
      required this.service});

  @override
  State<BookingOrders> createState() => _BookingOrdersState();
}

class _BookingOrdersState extends State<BookingOrders> {
  int convertStringToInteger(String stringValue) {
    double doubleValue = double.tryParse(stringValue) ?? 0.0;
    int integerValue = doubleValue.toInt();
    return integerValue;
  }

  Future<void> deleteOrderForCurrentUser(String documentId) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('Orders');

      DocumentReference documentReference = collectionReference.doc(documentId);

      await documentReference.delete();

      CustomSnackBar(context, Text('order Cancelled Successfully'));
    } catch (error) {
      CustomSnackBar(
          context, Text('Error deleting document from Firestore: $error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      widget.date.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.name.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.service.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.location.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      convertStringToInteger(widget.price.toString())
                          .toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
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
                                return Container(
                                  width: double.infinity,
                                  height: 400,
                                  color: Colors.white,
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
                                            width: 50,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryPink,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Center(
                                            child: Text(
                                          'Are you sure you want to cancel your booking with "${widget.artName}" ?\n\n Cancellation charges apply',
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
                                                    deleteOrderForCurrentUser(
                                                            widget.orderID
                                                                .toString())
                                                        .whenComplete(() =>
                                                            Navigator.pop(
                                                                context));
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
