import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
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
                'Payment method',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            TextInputFeildWidget(labelText: 'Card Number'),
            Row(
              children: [
                Expanded(child: TextInputFeildWidget(labelText: 'Expiration')),
                Expanded(child: TextInputFeildWidget(labelText: 'CVV')),
              ],
            ),
            TextInputFeildWidget(labelText: 'Postdode'),
            TextInputFeildWidget(labelText: 'Countr / region'),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: MyTextCard(
                      title: 'Cancel',
                      fontSize: 15,
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: MyCardButton(title: 'Done')))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
