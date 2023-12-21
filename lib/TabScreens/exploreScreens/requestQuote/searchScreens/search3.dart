import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search4.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search3Screen extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;
  Map<String, double> makeupPrices;
  Map<String, double> hairPrices;
  Map<String, double> nailsPrices;
  String? title;
  Search3Screen(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails,
      required this.makeupPrices,
      required this.hairPrices,
      required this.nailsPrices,
      required this.title});

  @override
  State<Search3Screen> createState() => _Search3ScreenState();
}

class _Search3ScreenState extends State<Search3Screen> {
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

  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var makeupPrices = widget.makeupPrices;
    var hairPrices = widget.hairPrices;
    var nailsPrices = widget.nailsPrices;

    var results = <String>[
      filterPrices(makeupPrices),
      filterPrices(hairPrices),
      filterPrices(nailsPrices),
    ];

    var result = results.where((item) => item.isNotEmpty).join(', ');

    // Print the final result
    print(result);

    return Scaffold(
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
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.close,
                        size: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      widget.title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
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
                      result.isEmpty ? 'Free' : result,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: AppColors.lightPink,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'When',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                      height: 300,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (dateTime) {
                          _dateTime = dateTime;
                          setState(() {});
                          print("--------------$_dateTime");
                        },
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Search4Screen(
                              typeHair: widget.typeHair,
                              typeMakeup: widget.typeMakeup,
                              typeNails: widget.typeNails,
                              hairPrices: widget.hairPrices,
                              makeupPrices: widget.makeupPrices,
                              nailsPrices: widget.nailsPrices,
                              dateTime: _dateTime,
                              result: result,
                              title: widget.title.toString(),
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
