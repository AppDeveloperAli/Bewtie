// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/LandingPage/booking/bookingitem.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:bewtie/listsDesigns/bookingItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingScreenArtist extends StatefulWidget {
  const BookingScreenArtist({super.key});

  @override
  State<BookingScreenArtist> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreenArtist> {
  late Stream<MergedQuerySnapshot> _orderStream;

  @override
  void initState() {
    super.initState();
    _orderStream = createOrderStreamForCurrentUser();
  }

  Stream<MergedQuerySnapshot> createOrderStreamForCurrentUser() async* {
    String currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Orders');

    String startDocumentId = currentUserUid;
    String endDocumentId = '$currentUserUid~';

    Query query = collectionReference
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: startDocumentId)
        .where(FieldPath.documentId, isLessThan: endDocumentId);

    await for (QuerySnapshot querySnapshot in query.snapshots()) {
      List<DocumentSnapshot> mergedDocs = [];

      mergedDocs.addAll(querySnapshot.docs);

      yield MergedQuerySnapshot(mergedDocs);
    }
  }

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
                  CupertinoPageRoute(builder: (context) => const LandingPage()),
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
              child: StreamBuilder(
                stream: _orderStream,
                builder:
                    (context, AsyncSnapshot<MergedQuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text(
                      'Nothing to show in "Your Booking"',
                      style: TextStyle(color: Colors.white),
                    ));
                  } else {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Map<String, dynamic> orderData =
                            documents[index].data() as Map<String, dynamic>;

                        return BookingOrdersArtist(
                          date: orderData['date'],
                          location: orderData['location'],
                          name: orderData['name'],
                          price: orderData['price'],
                          service: orderData['service'],
                          orderID: orderData['orderID'],
                          artName: orderData['artname'],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class MergedQuerySnapshot {
  final List<DocumentSnapshot> docs;

  MergedQuerySnapshot(this.docs);
}
