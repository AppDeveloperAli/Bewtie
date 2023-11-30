import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelectionArtist.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LocationArtist extends StatefulWidget {
  const LocationArtist({super.key});

  @override
  State<LocationArtist> createState() => _LocationArtistState();
}

class _LocationArtistState extends State<LocationArtist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _locationController = TextEditingController();

  Future<void> updateLocation(String documentId) async {
    CollectionReference artistCollection = _firestore.collection('Artist');

    try {
      await artistCollection
          .doc(documentId)
          .collection("Post")
          .doc(documentId)
          .update({
        'Location': _locationController.text,
      });

      print('Location updated successfully!');
    } catch (e) {
      print('Error updating Location: $e');
    }
  }

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
                  'Your location',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              TextInputFeildWidgetArtist(
                labelText: 'Enter your location',
                controller: _locationController,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                print("-------$_locationController");
                _locationController.text != ""
                    ? updateLocation(_auth.currentUser!.uid)
                    : "";
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Expanded(
                      child: MyTextCardArtist(title: 'Cancel', fontSize: 18)),
                  Expanded(child: MyCardButton(title: 'Save'))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
