import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelectionArtist.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:flutter/material.dart';

class AvailibilityArtist extends StatelessWidget {
  const AvailibilityArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Your availability',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomCardArtist(title: 'Mon'),
              CustomCardArtist(title: 'Tue'),
              CustomCardArtist(title: 'Wed'),
              CustomCardArtist(title: 'Thu'),
              CustomCardArtist(title: 'Fri'),
              CustomCardArtist(title: 'Sat'),
              CustomCardArtist(title: 'Sun'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Expanded(
                      child: MyTextCardArtist(title: 'Cancel', fontSize: 18)),
                  Expanded(child: MyCardButton(title: 'Save'))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
