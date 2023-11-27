// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.arrow_back),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Payments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                          'Card name\nXXXX 0000',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text('\nExpiry XX/XX'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                      width: 130,
                      height: 50,
                      child: GestureDetector(
                          onTap: () {
                            showSheet();
                          },
                          child: MyCardButton(title: 'Remove'))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: double.infinity,
                height: 0.5,
                color: AppColors.primaryPink,
              ),
            ),
            items('Apple Pay'),
            Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.primaryPink,
            ),
            items('Paypal'),
            Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.primaryPink,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        '+Add card',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: MyTextCard(title: 'Select', fontSize: 16)),
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget items(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Expanded(flex: 3, child: MyTextCard(title: 'Select', fontSize: 16)),
          Expanded(
              flex: 3,
              child: GestureDetector(
                  onTap: () {
                    showSheet();
                  },
                  child: MyTextCard(title: 'Remove', fontSize: 16))),
        ],
      ),
    );
  }

  Future<dynamic> showSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 0.5,
                      color: AppColors.primaryPink,
                    ),
                  ),
                  Center(
                      child: Text(
                    'Are you sure you want to delete this card?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: MyCardButton(title: 'No')),
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: MyTextCard(title: 'Yes', fontSize: 18)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
