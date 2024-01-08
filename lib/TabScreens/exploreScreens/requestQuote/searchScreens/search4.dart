// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/TabScreens/exploreScreens/exploreDetails.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/searchScreen.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

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
                        controller: _controller,
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
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const LandingPage()));
                      },
                      child: MyTextCard(title: 'Cancel', fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            Navigator.of(context).push(CupertinoPageRoute(
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
