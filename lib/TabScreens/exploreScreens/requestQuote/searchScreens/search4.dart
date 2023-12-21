// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/TabScreens/exploreScreens/exploreDetails.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/searchScreen.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search4Screen extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;
  final Map<String, double> makeupPrices;
  final Map<String, double> hairPrices;
  final Map<String, double> nailsPrices;
  final DateTime dateTime;
  String? title, result;

  Search4Screen(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails,
      required this.makeupPrices,
      required this.hairPrices,
      required this.nailsPrices,
      required this.dateTime,
      required this.title,
      required this.result});

  @override
  State<Search4Screen> createState() => _Search4ScreenState();
}

class _Search4ScreenState extends State<Search4Screen> {
  @override
  Widget build(BuildContext context) {
    print("-------${widget.typeMakeup}");
    print("-------${widget.typeHair}");
    print("-------${widget.typeNails}");
    print("-------${widget.hairPrices}");
    print("-------${widget.nailsPrices}");
    print("-------${widget.makeupPrices}");
    print("-------${widget.dateTime}");

    DateTime widgetDateTime = widget.dateTime;

    String formattedDate = DateFormat('EEEE d MMMM').format(widgetDateTime);

    TextEditingController controller = TextEditingController();

    return Scaffold(
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
                        child: Icon(Icons.close, size: 40),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        widget.title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: AppColors.lightPink,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        widget.result!.isEmpty
                            ? 'Free'
                            : widget.result.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: AppColors.lightPink,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: AppColors.lightPink,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Where',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Enter your destination here...',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LandingPage()));
                      },
                      child: MyTextCard(title: 'Cancel', fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchScreen(
                                      typeHair: widget.typeHair,
                                      typeMakeup: widget.typeMakeup,
                                      typeNails: widget.typeNails,
                                      hairPrices: widget.hairPrices,
                                      makeupPrices: widget.makeupPrices,
                                      nailsPrices: widget.nailsPrices,
                                      date: formattedDate,
                                      result: widget.result,
                                      title: widget.title.toString(),
                                      location: controller.text,
                                    )));
                          } else {
                            CustomSnackBar(
                                context, Text('Please give a destination...'));
                          }
                        },
                        child: MyCardButton(title: 'Search')),
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
