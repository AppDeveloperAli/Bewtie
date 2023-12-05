import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPhoneScreenArtist extends StatefulWidget {
  const EditPhoneScreenArtist({super.key});

  @override
  State<EditPhoneScreenArtist> createState() => _EditPhoneScreenArtistState();
}

class _EditPhoneScreenArtistState extends State<EditPhoneScreenArtist> {
  TextEditingController nmbrController = TextEditingController();
  String countryTitle = 'United Kingdom';
  String phoneCode = '';

  Future<void> upladeData(BuildContext context, String number) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Artist');
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final DocumentReference profileDataDoc = users
          .doc(currentUser.uid)
          .collection('Profile_Data')
          .doc(currentUser.uid);

      final DocumentSnapshot userDoc = await profileDataDoc.get();

      if (userDoc.exists) {
        await profileDataDoc.update({
          'number': number,
        });
      } else {
        await profileDataDoc.set({
          'number': number,
        });
      }

      Navigator.pop(context);
      CustomSnackBar(context, Text('Number Updated...'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Update your phone number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
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
                  TextInputFeildWidgetArtist(
                    controller: nmbrController,
                    labelText: 'Phone Number',
                    keyboardType: TextInputType.phone,
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
                print(phoneCode);

                if (nmbrController.text.isNotEmpty && phoneCode.isNotEmpty) {
                  await upladeData(context, phoneNumber);
                } else {
                  CustomSnackBar(
                      context,
                      const Text(
                          'Please select your country and put your number'));
                }
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
