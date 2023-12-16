import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  TextEditingController cardName = TextEditingController();
  TextEditingController cardNmber = TextEditingController();
  TextEditingController expireNmber = TextEditingController();
  TextEditingController cvvNmber = TextEditingController();
  TextEditingController postNmber = TextEditingController();

  bool isLoading = false;

  String? countryTitle;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUserId() {
    User? user = _auth.currentUser;
    return user!.uid;
  }

  void uploadData() {
    setState(() {
      isLoading = true;
    });
    String userId = getCurrentUserId();

    FirebaseFirestore.instance.collection('Users').doc(userId).update({
      'payments': FieldValue.arrayUnion([
        {
          'cardName': cardName.text,
          'cardNumber': cardNmber.text,
          'expire': expireNmber.text,
          'cvv': cvvNmber.text,
          'postal': postNmber.text,
          'country': countryTitle
        }
      ]),
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar(context, const Text('Payment method added.'));
      Navigator.pop(context);
    }).catchError((error) {
      CustomSnackBar(context, Text('Error uploading data: $error'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                        child: const Icon(
                          Icons.close,
                          size: 40,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Payment method',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      TextInputFeildWidget(
                        labelText: 'Card Name',
                        controller: cardName,
                        keyboardType: TextInputType.name,
                      ),
                      TextInputFeildWidget(
                        labelText: 'Card Number',
                        controller: cardNmber,
                        maxLines: 16,
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextInputFeildWidget(
                            labelText: 'Expiration',
                            maxLines: 4,
                            controller: expireNmber,
                            keyboardType: TextInputType.number,
                          )),
                          Expanded(
                              child: TextInputFeildWidget(
                            labelText: 'CVV',
                            controller: cvvNmber,
                            maxLines: 3,
                            keyboardType: TextInputType.number,
                          )),
                        ],
                      ),
                      TextInputFeildWidget(
                        labelText: 'Postal Code',
                        keyboardType: TextInputType.number,
                        controller: postNmber,
                        maxLines: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              setState(() {
                                countryTitle = country.name;
                              });
                            },
                          );
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(color: Colors.black),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: double.infinity,
                            height: 80.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Country / region',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  countryTitle ?? 'Select your country',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                              // Navigator.pop(context);
                              if (cardNmber.text.isNotEmpty &&
                                  expireNmber.text.isNotEmpty &&
                                  cardName.text.isNotEmpty &&
                                  cvvNmber.text.isNotEmpty &&
                                  postNmber.text.isNotEmpty &&
                                  countryTitle != null) {
                                // uploadData(context);
                                uploadData();
                              } else {
                                CustomSnackBar(context,
                                    const Text('All fields must be filled.'));
                              }
                            },
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : MyCardButton(title: 'Done')))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
