// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/becomeArtist3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BecomeArtistScreen2 extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;

  const BecomeArtistScreen2(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails});

  @override
  State<BecomeArtistScreen2> createState() => _Search2ScreenState();
}

class _Search2ScreenState extends State<BecomeArtistScreen2> {
  double priceMakeup = 0;
  double priceHair = 0;
  double priceNails = 0;

  // List<double> priceMakeup = [];
  //List<double> priceHair = [];
  // List<double> priceNails = [];

  List makeupSliderValues = [];
  List hairSliderValues = [];
  List nailsSliderValues = [];

  //
  List<double> priceMakeupList = [];
  List<double> priceHairList = [];
  List<double> priceNailsList = [];

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
    print("---------------------------------");
    print("Makeup : ${widget.typeMakeup}");
    print("Hair : ${widget.typeHair}");
    print("Nails : ${widget.typeNails}");

    double _currentSliderValue = 0;
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
                      'Make-up (Bridal)...',
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
                      'How much',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.typeMakeup.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      widget.typeMakeup[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      '${makeupSliderValues[index].toInt()} €',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
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
                                      makeupPrices[widget.typeMakeup[index]] =
                                          value;
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
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0),
                  //   child: Text(
                  //     'Make-up',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           widget.typeMakeup.join(', '),
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           '${_mackupSliderValue.toInt()} €',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
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
                  //       value: _mackupSliderValue,
                  //       min: 0,
                  //       max: 500,
                  //       divisions: 50,
                  //       thumbColor: AppColors.primaryPink,
                  //       onChanged: (value) {
                  //         priceMakeup = value;
                  //         setState(() => _mackupSliderValue = value);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  //
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.typeHair.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      widget.typeHair[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      '${hairSliderValues[index].toInt()} €',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
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
                                      hairPrices[widget.typeHair[index]] =
                                          value;
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
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0, top: 20),
                  //   child: Text(
                  //     'Hair',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           widget.typeHair.join(', '),
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           '${_hairSliderValue.toInt()} €',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
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
                  //       value: _hairSliderValue,
                  //       min: 0,
                  //       max: 500,
                  //       divisions: 50,
                  //       thumbColor: AppColors.primaryPink,
                  //       onChanged: (value) {
                  //         priceHair = value;
                  //         setState(() => _hairSliderValue = value);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  //
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.typeNails.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      widget.typeNails[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      '${nailsSliderValues[index].toInt()} €',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
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
                                      nailsPrices[widget.typeNails[index]] =
                                          value;
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
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0, top: 20),
                  //   child: Text(
                  //     'Nails',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           widget.typeNails.join(', '),
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           '${_nailsSliderValue.toInt()} €',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
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
                  //       value: _nailsSliderValue,
                  //       min: 0,
                  //       max: 500,
                  //       divisions: 50,
                  //       thumbColor: AppColors.primaryPink,
                  //       onChanged: (value) {
                  //         priceNails = value;

                  //         setState(() => _nailsSliderValue = value);
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    //

                    print("Price Makeup: ${makeupPrices}");
                    print("Price Hair: ${hairPrices}");
                    print("Price Nails: ${nailsPrices}");

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BecomeArtist3(
                              typeMakeup: widget.typeMakeup,
                              typeHair: widget.typeHair,
                              typeNails: widget.typeNails,
                              makeupPrices: makeupPrices,
                              hairPrices: hairPrices,
                              nailsPrices: nailsPrices,
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
