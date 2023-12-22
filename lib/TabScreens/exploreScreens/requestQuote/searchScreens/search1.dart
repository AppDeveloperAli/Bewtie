// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelection.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search2.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search1Screen extends StatefulWidget {
  const Search1Screen({super.key});

  @override
  State<Search1Screen> createState() => _Search1ScreenState();
}

class _Search1ScreenState extends State<Search1Screen> {
  List<String> typeMakeup = [];
  List<String> typeHair = [];
  List<String> typeNails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Which service',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  'Make-up',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              CustomCard(
                title: 'Bridal',
                onTap: () {
                  if (typeMakeup.contains("Bridal")) {
                    typeMakeup.remove("Bridal");
                  } else {
                    typeMakeup.add("Bridal");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Editorial',
                onTap: () {
                  if (typeMakeup.contains("Editorial")) {
                    typeMakeup.remove("Editorial");
                  } else {
                    typeMakeup.add("Editorial");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Film & TV',
                onTap: () {
                  if (typeMakeup.contains("Film & TV")) {
                    typeMakeup.remove("Film & TV");
                  } else {
                    typeMakeup.add("Film & TV");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Party',
                onTap: () {
                  if (typeMakeup.contains("Party")) {
                    typeMakeup.remove("Party");
                  } else {
                    typeMakeup.add("Party");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Special Effects',
                onTap: () {
                  if (typeMakeup.contains("Special Effects")) {
                    typeMakeup.remove("Special Effects");
                  } else {
                    typeMakeup.add("Special Effects");
                  }
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                ),
                child: Text(
                  'Hair',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              CustomCard(
                title: 'Bridal',
                onTap: () {
                  if (typeHair.contains("Bridal")) {
                    typeHair.remove("Bridal");
                  } else {
                    typeHair.add("Bridal");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Editorial',
                onTap: () {
                  if (typeHair.contains("Editorial")) {
                    typeHair.remove("Editorial");
                  } else {
                    typeHair.add("Editorial");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Film & TV',
                onTap: () {
                  if (typeHair.contains("Film & TV")) {
                    typeHair.remove("Film & TV");
                  } else {
                    typeHair.add("Film & TV");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Party',
                onTap: () {
                  if (typeHair.contains("Party")) {
                    typeHair.remove("Party");
                  } else {
                    typeHair.add("Party");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Special Effects',
                onTap: () {
                  if (typeHair.contains("Special Effects")) {
                    typeHair.remove("Special Effects");
                  } else {
                    typeHair.add("Special Effects");
                  }
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  'Nails',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              CustomCard(
                title: 'Bridal',
                onTap: () {
                  if (typeNails.contains("Bridal")) {
                    typeNails.remove("Bridal");
                  } else {
                    typeNails.add("Bridal");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Editorial',
                onTap: () {
                  if (typeNails.contains("Editorial")) {
                    typeNails.remove("Editorial");
                  } else {
                    typeNails.add("Editorial");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Film & TV',
                onTap: () {
                  if (typeNails.contains("Film & TV")) {
                    typeNails.remove("Film & TV");
                  } else {
                    typeNails.add("Film & TV");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Party',
                onTap: () {
                  if (typeNails.contains("Party")) {
                    typeNails.remove("Party");
                  } else {
                    typeNails.add("Party");
                  }
                  setState(() {});
                },
              ),
              CustomCard(
                title: 'Special Effects',
                onTap: () {
                  if (typeNails.contains("Special Effects")) {
                    typeNails.remove("Special Effects");
                  } else {
                    typeNails.add("Special Effects");
                  }
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
                child: GestureDetector(
                    onTap: () {
                      if (typeHair.isNotEmpty ||
                          typeMakeup.isNotEmpty ||
                          typeNails.isNotEmpty) {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => Search2Screen(
                                  typeHair: typeHair,
                                  typeMakeup: typeMakeup,
                                  typeNails: typeNails,
                                )));
                      } else {
                        CustomSnackBar(
                            context, Text('Select at least one Type..'));
                      }
                    },
                    child: MyCardButton(title: 'Next')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
