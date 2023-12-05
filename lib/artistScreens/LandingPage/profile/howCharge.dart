// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:bewtie/Components/cardButton.dart';
// import 'package:bewtie/Components/cardTextArtist.dart';
// import 'package:bewtie/Utils/colors.dart';
// import 'package:bewtie/artistScreens/becomeArtist3.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class HowCharge extends StatefulWidget {
//   const HowCharge({super.key});

//   @override
//   State<HowCharge> createState() => _Search2ScreenState();
// }

// class _Search2ScreenState extends State<HowCharge> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Icon(
//                         Icons.close,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       'How much do you charge?',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0),
//                     child: Text(
//                       'Make-up',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, right: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             'Bridal',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             '0 €',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CupertinoSlider(
//                         value: _currentSliderValue,
//                         thumbColor: AppColors.primaryPink,
//                         // label: _currentSliderValue.round().toString(),
//                         onChanged: (value) {
//                           setState(() => _currentSliderValue = value);
//                         },
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0, top: 20),
//                     child: Text(
//                       'Hair',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, right: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             'Bridal',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             '0 €',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CupertinoSlider(
//                         value: _currentSliderValue,
//                         thumbColor: AppColors.primaryPink,
//                         // label: _currentSliderValue.round().toString(),
//                         onChanged: (value) {
//                           setState(() => _currentSliderValue = value);
//                         },
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0, top: 20),
//                     child: Text(
//                       'Nails',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, right: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             'Bridal',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             '0 €',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CupertinoSlider(
//                         value: _currentSliderValue,
//                         thumbColor: AppColors.primaryPink,
//                         // label: _currentSliderValue.round().toString(),
//                         onChanged: (value) {
//                           setState(() => _currentSliderValue = value);
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                     updatePrices(_auth.currentUser!.uid);
//                   },
//                   child: Row(
//                     children: [
//                       Expanded(
//                           child:
//                               MyTextCardArtist(title: 'Cancel', fontSize: 18)),
//                       Expanded(
//                         child: MyCardButton(title: 'Next'),
//                       ),
//                     ],
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//
import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/becomeArtist3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HowCharge extends StatefulWidget {
  const HowCharge({super.key});

  @override
  State<HowCharge> createState() => _Search2ScreenState();
}

class _Search2ScreenState extends State<HowCharge> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<double> priceMakeupList = [];
  List<double> priceHairList = [];
  List<double> priceNailsList = [];

  Map<String, double> makeupPrices = {};
  Map<String, double> hairPrices = {};
  Map<String, double> nailsPrices = {};

  List makeupSliderValues = [];
  List hairSliderValues = [];
  List nailsSliderValues = [];

  List typeMakeup = [];
  List typeHair = [];
  List typeNails = [];

  Future<void> getSkillsData(String documentId) async {
    try {
      // Replace 'your_collection' with the name of your Firestore collection
      CollectionReference<Map<String, dynamic>> artistCollection =
          _firestore.collection('Artist');

      // Replace 'your_document_id' with the ID of the document you want to retrieve
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await artistCollection
              .doc(documentId)
              .collection("Post")
              .doc(documentId)
              .get();

      if (documentSnapshot.exists) {
        // Extract specific fields from the document
        typeMakeup = documentSnapshot.get('Makeup Type');
        typeHair = documentSnapshot.get('Hair Type');
        typeNails = documentSnapshot.get('Nails Type');
        // Add more fields as needed

        print('------typeMakeup: $typeMakeup');
        print('------typeHair: $typeHair');
        print('------typeNails: $typeNails');

        // Print or use other fields as needed
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> updatePrices(String documentId) async {
    CollectionReference artistCollection = _firestore.collection('Artist');

    try {
      await artistCollection
          .doc(documentId)
          .collection("Post")
          .doc(documentId)
          .update({
        'Price Makeup': makeupPrices,
        'Price Hair': hairPrices,
        'Price Nails': nailsPrices,
      });

      print('Prices updated successfully!');
    } catch (e) {
      print('Error updating Prices: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getSkillsData(_auth.currentUser!.uid);

    setState(() {
      makeupSliderValues = List.generate(
        typeMakeup.length,
        (index) => 0.0,
      );

      hairSliderValues = List.generate(
        typeHair.length,
        (index) => 0.0,
      );

      nailsSliderValues = List.generate(
        typeNails.length,
        (index) => 0.0,
      );

      makeupPrices = {for (var type in typeMakeup) type: 0.0};
      hairPrices = {for (var type in typeHair) type: 0.0};
      nailsPrices = {for (var type in typeNails) type: 0.0};
    });

    print("======$typeMakeup");
    print("======$makeupPrices");
  }

  @override
  Widget build(BuildContext context) {
    double _currentSliderValue = 0;
    return Scaffold(
      backgroundColor: Colors.black,
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'How much do you charge?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Make-up',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //
                  Expanded(
                    child: ListView.builder(
                      itemCount: typeMakeup.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      typeMakeup[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      '${makeupSliderValues[index].toInt()} €',
                                      style: TextStyle(
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
                                      makeupPrices[typeMakeup[index]] = value;
                                      makeupSliderValues[index] = value;
                                    });
                                  },
                                  // onChanged: (value) {
                                  //   priceMakeup = value;
                                  //   setState(() =>
                                  //       makeupSliderValues[index] = value);
                                  // },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           'Bridal',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           '0 €',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: CupertinoSlider(
                  //       value: _currentSliderValue,
                  //       thumbColor: AppColors.primaryPink,
                  //       // label: _currentSliderValue.round().toString(),
                  //       onChanged: (value) {
                  //         setState(() => _currentSliderValue = value);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  //
                  Expanded(
                    child: ListView.builder(
                      itemCount: typeHair.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      typeHair[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      '${hairSliderValues[index].toInt()} €',
                                      style: TextStyle(
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
                                  // onChanged: (value) {
                                  //   priceHair = value;
                                  //   setState(
                                  //       () => hairSliderValues[index] = value);
                                  // },

                                  onChanged: (value) {
                                    setState(() {
                                      hairPrices[typeHair[index]] = value;
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
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0, top: 20),
                  //   child: Text(
                  //     'Hair',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           'Bridal',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           '0 €',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: CupertinoSlider(
                  //       value: _currentSliderValue,
                  //       thumbColor: AppColors.primaryPink,
                  //       // label: _currentSliderValue.round().toString(),
                  //       onChanged: (value) {
                  //         setState(() => _currentSliderValue = value);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  //

                  Expanded(
                    child: ListView.builder(
                      itemCount: typeNails.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      typeNails[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      '${nailsSliderValues[index].toInt()} €',
                                      style: TextStyle(
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
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     priceNailsList[index] = value;
                                  //     nailsSliderValues[index] = value;
                                  //   });
                                  // },

                                  onChanged: (value) {
                                    setState(() {
                                      nailsPrices[typeNails[index]] = value;
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
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0, top: 20),
                  //   child: Text(
                  //     'Nails',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           'Bridal',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Text(
                  //           '0 €',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: CupertinoSlider(
                  //       value: _currentSliderValue,
                  //       thumbColor: AppColors.primaryPink,
                  //       // label: _currentSliderValue.round().toString(),
                  //       onChanged: (value) {
                  //         setState(() => _currentSliderValue = value);
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    updatePrices(_auth.currentUser!.uid);
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child:
                              MyTextCardArtist(title: 'Cancel', fontSize: 18)),
                      Expanded(
                        child: MyCardButton(title: 'Next'),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
