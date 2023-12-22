// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/quoteScreens/billing.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentsScreenArtist extends StatefulWidget {
  const PaymentsScreenArtist({super.key});

  @override
  State<PaymentsScreenArtist> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreenArtist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    String currentUserId = auth.currentUser!.uid;

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
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Payments',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection('Users')
                    .doc(currentUserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text('User data not found.');
                  } else {
                    List<dynamic> paymentsArray = snapshot.data!['payments'];

                    List<Map<String, dynamic>> paymentsList =
                        List<Map<String, dynamic>>.from(paymentsArray);

                    return paymentsArray.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                'Please add your Payment Methods',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 15, left: 15),
                                          child: Text(
                                            '${paymentsList[selectedindex]['cardName']}\n${paymentsList[selectedindex]['cardNumber']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            '\nExpiry ${paymentsList[selectedindex]['expire']}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
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
                                              showSheet(selectedindex);
                                            },
                                            child:
                                                MyCardButton(title: 'Remove'))),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  color: AppColors.primaryPink,
                                ),
                              ),
                              ListView.builder(
                                itemCount: paymentsList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return items(
                                      paymentsList[index]['cardName'], index);
                                },
                              ),
                            ],
                          );
                  }
                },
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
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => const BillingScreen()));
                            },
                            child: MyTextCardArtist(
                                title: 'Select', fontSize: 16))),
                    Expanded(flex: 3, child: Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget items(String title, int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: GestureDetector(
                      onTap: () => setState(() {
                            selectedindex = index;
                          }),
                      child: MyTextCardArtist(title: 'Select', fontSize: 16))),
              Expanded(
                  flex: 3,
                  child: GestureDetector(
                      onTap: () {
                        showSheet(index);
                      },
                      child: MyTextCardArtist(title: 'Remove', fontSize: 16))),
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
        ],
      ),
    );
  }

  Future<dynamic> showSheet(int index) {
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
                              deletePaymentField(index);
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

  void deletePaymentField(int index) {
    DocumentReference userDocRef =
        _firestore.collection('Users').doc(auth.currentUser!.uid);

    if (selectedindex == index) {
      selectedindex = 0;
    }

    userDocRef.get().then((doc) {
      if (doc.exists) {
        List<dynamic> paymentsArray = doc['payments'];

        if (index >= 0 && index < paymentsArray.length) {
          paymentsArray.removeAt(index);

          userDocRef.update({'payments': paymentsArray}).then((_) {
            print('Payment field removed successfully.');
          }).catchError((error) {
            print('Error updating payments array: $error');
          });
        } else {
          print('Invalid index: $index');
        }
      } else {
        print('User document not found.');
      }
    }).catchError((error) {
      print('Error fetching user document: $error');
    });
  }
}
