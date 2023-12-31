// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/LandingPage/mainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       elevation: 0,
  //       title: Text(
  //         'Google Map Search places Api',
  //       ),
  //     ),
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         Align(
  //           alignment: Alignment.topCenter,
  //           child: TextField(
  //             controller: _controller,
  //             decoration: InputDecoration(
  //               hintText: "Seek your location here",
  //               focusColor: Colors.white,
  //               floatingLabelBehavior: FloatingLabelBehavior.never,
  //               prefixIcon: Icon(Icons.map),
  //               suffixIcon: IconButton(
  //                 icon: Icon(Icons.cancel),
  //                 onPressed: () {
  //                   _controller.clear();
  //                 },
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

/////////////////////

  var _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDjY2FhuQ9P8QYBNoRBYIha0dLLRJnohDg";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // toastMessage('success');
    }
  }

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
                        result.isEmpty ? 'Free' : result,
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
                          controller: _controller,
                        )),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _placeList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {},
                          child: ListTile(
                            title: Text(_placeList[index]["description"]),
                          ),
                        );
                      },
                    )
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
