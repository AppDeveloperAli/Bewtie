import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPhoneScreen extends StatefulWidget {
  EditPhoneScreen({super.key});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  TextEditingController nmbrController = TextEditingController();
  String countryTitle = 'United Kingdom';
  String phoneCode = '';

  Future<void> upladeData(BuildContext context, String number) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot userDoc = await users.doc(currentUser.uid).get();

      if (userDoc.exists) {
        await users.doc(currentUser.uid).update({
          'number': number,
        });
        Navigator.pop(context);
        CustomSnackBar(context, Text('Number Updated...'));
      } else {
        await users.doc(currentUser.uid).set({
          'number': number,
        });
        Navigator.pop(context);
        CustomSnackBar(context, Text('Number Updated...'));
      }
    }
  }

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
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.close,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Update your phone number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            countryTitle = country.displayName;
                            phoneCode = country.phoneCode;
                            print(countryTitle);
                          });
                        },
                      );
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.black),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: 80.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Country / region',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              countryTitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextInputFeildWidget(
                    controller: nmbrController,
                    labelText: 'Phone Number',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () async {
                String phoneNumber = '+$phoneCode${nmbrController.text}';

                print(phoneNumber);
                await upladeData(context, phoneNumber);
              },
              child: MyCardButton(
                title: 'Update',
              ),
            ),
          )
        ],
      )),
    );
  }
}
