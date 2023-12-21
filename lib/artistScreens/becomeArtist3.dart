// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelectionArtist.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search4.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/becomeArtist4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BecomeArtist3 extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;
  final double packageTotal;
  Map<String, double> makeupPrices;
  Map<String, double> hairPrices;
  Map<String, double> nailsPrices;

  // final double priceMakeup;
  // final double priceHair;
  // final double priceNails;
  BecomeArtist3(
      {super.key,
      required this.makeupPrices,
      required this.hairPrices,
      required this.nailsPrices,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails,
      required this.packageTotal});

  @override
  State<BecomeArtist3> createState() => _Search3ScreenState();
}

class _Search3ScreenState extends State<BecomeArtist3> {
  final List<String> availability = [];
  @override
  Widget build(BuildContext context) {
    print("----------${widget.typeMakeup}");
    print("------${widget.hairPrices}");
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
                      originalString.toString(),
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
                      'Your availibilty',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomCardArtist(
                    dataList: [],
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
                    dataList: [],
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
                    dataList: [],
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
                    dataList: [],
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
                    dataList: [],
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
                    dataList: [],
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
                    dataList: [],
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
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    print("---------$availability");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BecomeArtistScreen4(
                              typeMakeup: widget.typeMakeup,
                              typeHair: widget.typeHair,
                              typeNails: widget.typeNails,
                              makeupPrices: widget.makeupPrices,
                              hairPrices: widget.hairPrices,
                              nailsPrices: widget.nailsPrices,
                              packageTotal: widget.packageTotal,
                              availability: availability,
                            )));
                  },
                  child: MyCardButton(title: 'Next')),
            )
          ],
        ),
      ),
    );
  }
}
