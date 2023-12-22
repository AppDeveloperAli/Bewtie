// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search3.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search2Screen extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;
  const Search2Screen(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails});

  @override
  State<Search2Screen> createState() => _Search2ScreenState();
}

class _Search2ScreenState extends State<Search2Screen> {
  List makeupSliderValues = [];
  List hairSliderValues = [];
  List nailsSliderValues = [];

  Map<String, double> makeupPrices = {};
  Map<String, double> hairPrices = {};
  Map<String, double> nailsPrices = {};

  @override
  void initState() {
    super.initState();

    makeupSliderValues = List.generate(
      widget.typeMakeup.length,
      (index) => 0.0,
    );
    //
    hairSliderValues = List.generate(
      widget.typeHair.length,
      (index) => 0.0,
    );
    //
    nailsSliderValues = List.generate(
      widget.typeNails.length,
      (index) => 0.0,
    );
    //
    makeupPrices = {for (var type in widget.typeMakeup) type: 0.0};
    hairPrices = {for (var type in widget.typeHair) type: 0.0};
    nailsPrices = {for (var type in widget.typeNails) type: 0.0};
  }

  @override
  Widget build(BuildContext context) {
    String originalString =
        'Make up ${(widget.typeMakeup)}, Nails ${widget.typeNails}, Hair ${widget.typeHair}';

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
                  originalString.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                  'How much',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              widget.typeMakeup.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Make-up',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.typeMakeup.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                widget.typeMakeup[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '${makeupSliderValues[index].toInt()} €',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoSlider(
                            value: makeupSliderValues[index],
                            min: 0,
                            max: 500,
                            divisions: 50,
                            thumbColor: AppColors.primaryPink,

                            onChanged: (value) {
                              setState(() {
                                makeupPrices[widget.typeMakeup[index]] = value;
                                makeupSliderValues[index] = value;
                              });
                            },
                            // onChanged: (value) {
                            //   priceMakeup = value;
                            //   setState(() =>
                            //       makeupSliderValues[index] = value);
                            // },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 10, right: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(left: 20.0),
              //         child: Text(
              //           'Bridal',
              //           style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 20.0),
              //         child: Text(
              //           '0 €',
              //           style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: CupertinoSlider(
              //       value: _currentSliderValue,
              //       thumbColor: AppColors.primaryPink,
              //       // label: _currentSliderValue.round().toString(),
              //       onChanged: (value) {
              //         setState(() => _currentSliderValue = value);
              //       },
              //     ),
              //   ),
              // ),
              widget.typeHair.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20),
                      child: Text(
                        'Hair',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
              //
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.typeHair.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                widget.typeHair[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '${hairSliderValues[index].toInt()} €',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoSlider(
                            value: hairSliderValues[index],
                            min: 0,
                            max: 500,
                            divisions: 50,
                            thumbColor: AppColors.primaryPink,
                            // onChanged: (value) {
                            //   priceHair = value;
                            //   setState(
                            //       () => hairSliderValues[index] = value);
                            // },

                            onChanged: (value) {
                              setState(() {
                                hairPrices[widget.typeHair[index]] = value;
                                hairSliderValues[index] = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10, right: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(left: 20.0),
              //         child: Text(
              //           'Bridal',
              //           style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 20.0),
              //         child: Text(
              //           '0 €',
              //           style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: CupertinoSlider(
              //       value: _currentSliderValue,
              //       thumbColor: AppColors.primaryPink,
              //       // label: _currentSliderValue.round().toString(),
              //       onChanged: (value) {
              //         setState(() => _currentSliderValue = value);
              //       },
              //     ),
              //   ),
              // ),
              widget.typeNails.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20),
                      child: Text(
                        'Nails',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
              //
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.typeNails.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                widget.typeNails[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '${nailsSliderValues[index].toInt()} €',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoSlider(
                            value: nailsSliderValues[index],
                            min: 0,
                            max: 500,
                            divisions: 50,
                            thumbColor: AppColors.primaryPink,
                            // onChanged: (value) {
                            //   setState(() {
                            //     priceNailsList[index] = value;
                            //     nailsSliderValues[index] = value;
                            //   });
                            // },

                            onChanged: (value) {
                              setState(() {
                                nailsPrices[widget.typeNails[index]] = value;
                                nailsSliderValues[index] = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => Search3Screen(
                                hairPrices: hairPrices,
                                makeupPrices: makeupPrices,
                                nailsPrices: nailsPrices,
                                typeHair: widget.typeHair,
                                typeMakeup: widget.typeMakeup,
                                typeNails: widget.typeNails,
                                title: originalString,
                              )));
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
