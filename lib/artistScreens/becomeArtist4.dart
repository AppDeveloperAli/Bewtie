// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/LandingPage/mainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BecomeArtistScreen4 extends StatefulWidget {
  // From 1st Screen :-
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;

  // From 2nd Screen :-
  // final double priceMakeup;
  // final double priceHair;
  // final double priceNails;

  Map<String, double> makeupPrices;
  Map<String, double> hairPrices;
  Map<String, double> nailsPrices;

  // From 3rd Screen :-
  final List<String> availability;
  final double packageTotal;

  BecomeArtistScreen4(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails,
      required this.makeupPrices,
      required this.hairPrices,
      required this.nailsPrices,
      required this.availability,
      required this.packageTotal});

  @override
  State<BecomeArtistScreen4> createState() => _BecomeArtistScreen4State();
}

class _BecomeArtistScreen4State extends State<BecomeArtistScreen4> {
  bool isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _location = TextEditingController();
  String formattedDate = DateFormat('EEEE d MMMM').format(DateTime.now());

  void _createArtistCollection(String location) async {
    setState(() {
      isLoading = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference artistsCollection = _firestore.collection('Post');

    await artistsCollection.doc(auth.currentUser!.uid).update({
      'Makeup Type': widget.typeMakeup,
      'Hair Type': widget.typeHair,
      'Nails Type': widget.typeNails,
      'availability': widget.availability,
      'Location': location.toString(),
      'Price Makeup': widget.makeupPrices,
      'Price Hair': widget.hairPrices,
      'Price Nails': widget.nailsPrices,
      'UID': auth.currentUser!.uid,
      'Package Total': widget.packageTotal
    });

    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const ArtistMainPage()));
    setState(() {
      isLoading = false;
    });
    print('Artist collection created successfully.');
  }

  @override
  Widget build(BuildContext context) {
    print("--------${widget.typeMakeup}");
    print("--------${widget.makeupPrices}");
    print("--------${widget.availability}");

    String originalString =
        'Make up ${(widget.typeMakeup)}, Nails ${widget.typeNails}, Hair ${widget.typeHair}';

// Replace '[]' with '()' for the entire string
    originalString = originalString.replaceAll('[]', '()');

    if (widget.typeMakeup.isEmpty) {
      originalString = originalString.replaceAll(RegExp(r'Make up \(\),?'), '');
    } else {
      originalString = originalString.replaceFirst(
          RegExp(r'Make up \[\]'), 'Make up (${widget.typeMakeup})');
    }

    if (widget.typeNails.isEmpty) {
      originalString = originalString.replaceAll(RegExp(r'Nails \(\),?'), '');
    } else {
      originalString = originalString.replaceFirst(
          RegExp(r'Nails \[\]'), 'Nails (${widget.typeNails})');
    }

    if (widget.typeHair.isEmpty) {
      originalString = originalString.replaceAll(RegExp(r'Hair \(\),?'), '');
    } else {
      originalString = originalString.replaceFirst(
          RegExp(r'Hair \[\]'), 'Hair (${widget.typeHair})');
    }

    originalString = originalString.replaceAll('[', '(').replaceAll(']', ')');
    String filterPrices(Map<String, double> prices) {
      var filteredPrices =
          prices.entries.where((entry) => entry.value > 0.0).toList();

      var result = filteredPrices.map((entry) {
        var categoryName = entry.key;
        var price = entry.value % 1 == 0
            ? entry.value.toInt().toString()
            : entry.value
                .toStringAsFixed(2)
                .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
        return '$categoryName: $price';
      }).join(', ');

      return result;
    }

    var makeupPrices = widget.makeupPrices;
    var hairPrices = widget.hairPrices;
    var nailsPrices = widget.nailsPrices;
    var results = <String>[
      filterPrices(makeupPrices),
      filterPrices(hairPrices),
      filterPrices(nailsPrices),
    ];

    var result = results.where((item) => item.isNotEmpty).join(', ');

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
                        originalString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                        result,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                        formattedDate,
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
                            _createArtistCollection(_location.text);
                          },
                          child: isLoading
                              ? Center(child: CircularProgressIndicator())
                              : MyCardButton(title: 'Submit')),
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
