import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;
  final Map<String, double> makeupPrices;
  final Map<String, double> hairPrices;
  final Map<String, double> nailsPrices;
  String? title, result, date, location;

  SearchScreen(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails,
      required this.makeupPrices,
      required this.hairPrices,
      required this.nailsPrices,
      required this.title,
      required this.result,
      required this.date,
      required this.location});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    print("-------${widget.typeMakeup}");
    print("-------${widget.typeHair}");
    print("-------${widget.typeNails}");
    print("-------${widget.hairPrices}");
    print("-------${widget.nailsPrices}");
    print("-------${widget.makeupPrices}");
    print("-------${widget.date}");
    print("-------${widget.result}");
    print("-------${widget.location}");

    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
