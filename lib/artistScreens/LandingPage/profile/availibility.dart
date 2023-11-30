import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelectionArtist.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvailibilityArtist extends StatefulWidget {
  const AvailibilityArtist({super.key});

  @override
  State<AvailibilityArtist> createState() => _AvailibilityArtistState();
}

class _AvailibilityArtistState extends State<AvailibilityArtist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> availability = [];

  Future<void> updateAvailability(String documentId) async {
    CollectionReference artistCollection = _firestore.collection('Artist');

    try {
      await artistCollection
          .doc(documentId)
          .collection("Post")
          .doc(documentId)
          .update({
        'availability': availability,
      });

      print('Availability updated successfully!');
    } catch (e) {
      print('Error updating Availability: $e');
    }
  }

  // void updateAvailability(String location) async {

  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   final CollectionReference artistsCollection =
  //       _firestore.collection('Artist');

  //   await artistsCollection
  //       .doc(auth.currentUser!.uid)
  //       .collection("Post")
  //       .doc(auth.currentUser!.uid)
  //       .set({
  //     'Makeup Type': widget.typeMakeup,
  //     'Hair Type': widget.typeHair,
  //     'Nails Type': widget.typeNails,
  //     'availability': widget.availability,
  //     'Location': location.toString(),
  //     'Price Makeup': widget.priceMakeup,
  //     'Price Hair': widget.priceHair,
  //     'Price Nails': widget.priceNails,
  //   });

  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => const ArtistMainPage()));
  //   setState(() {
  //     isLoading = false;
  //   });
  //   print('Artist collection created successfully.');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Your availability',
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                print("--------$availability");

                availability.isNotEmpty
                    ? updateAvailability(_auth.currentUser!.uid)
                    : "";
              },
              child: Row(
                children: [
                  Expanded(
                      child: MyTextCardArtist(title: 'Cancel', fontSize: 18)),
                  Expanded(
                      child: MyCardButton(
                    title: 'Save',
                  ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
