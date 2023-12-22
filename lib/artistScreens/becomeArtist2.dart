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
  double total = 0;
  double packageTotal = 0;

  List makeupSliderValues = [];
  List hairSliderValues = [];
  List nailsSliderValues = [];

  Map<String, double> makeupPrices = {};
  Map<String, double> hairPrices = {};
  Map<String, double> nailsPrices = {};
  Map<String, double> totalPrices = {};

  @override
  void initState() {
    super.initState();

    makeupSliderValues = List.generate(
      widget.typeMakeup.length,
      (index) => 0.0,
    );

    hairSliderValues = List.generate(
      widget.typeHair.length,
      (index) => 0.0,
    );

    nailsSliderValues = List.generate(
      widget.typeNails.length,
      (index) => 0.0,
    );

    makeupPrices = {for (var type in widget.typeMakeup) type: 0.0};
    hairPrices = {for (var type in widget.typeHair) type: 0.0};
    nailsPrices = {for (var type in widget.typeNails) type: 0.0};
  }

  void calculateTotal() {
    List<Map<String, double>> allPrices = [
      makeupPrices,
      nailsPrices,
      hairPrices
    ];

    for (var priceMap in allPrices) {
      priceMap.forEach((product, price) {
        totalPrices.update(product, (value) => value + price,
            ifAbsent: () => price);
      });
    }

    print('Total Prices: $totalPrices');

    Map<String, double> categoryPrices = totalPrices;

    packageTotal = categoryPrices.values.fold(0, (sum, price) => sum + price);
  }

  @override
  Widget build(BuildContext context) {
    print("---------------------------------");
    print("Makeup : ${widget.typeMakeup}");
    print("Hair : ${widget.typeHair}");
    print("Nails : ${widget.typeNails}");

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

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
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
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'How much',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              widget.typeMakeup.isEmpty
                  ? const CircularProgressIndicator()
                  : const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Make-up',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
              ListView.builder(
                itemCount: widget.typeMakeup.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '${makeupSliderValues[index].toInt()} €',
                                style: const TextStyle(
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
                                makeupPrices[widget.typeMakeup[index]] = value;
                                makeupSliderValues[index] = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              widget.typeHair.isEmpty
                  ? const CircularProgressIndicator()
                  : const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Hair',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '${hairSliderValues[index].toInt()} €',
                                style: const TextStyle(
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
              widget.typeNails.isEmpty
                  ? const CircularProgressIndicator()
                  : const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Nails',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '${nailsSliderValues[index].toInt()} €',
                                style: const TextStyle(
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
                      calculateTotal();

                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => BecomeArtist3(
                                typeMakeup: widget.typeMakeup,
                                typeHair: widget.typeHair,
                                typeNails: widget.typeNails,
                                makeupPrices: makeupPrices,
                                hairPrices: hairPrices,
                                nailsPrices: nailsPrices,
                                packageTotal: packageTotal,
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
