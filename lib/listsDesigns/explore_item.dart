import 'dart:isolate';

import 'package:bewtie/TabScreens/exploreScreens/exploreDetails.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExploreItemDesign extends StatefulWidget {
  const ExploreItemDesign({Key? key}) : super(key: key);

  @override
  State<ExploreItemDesign> createState() => _ExploreItemDesignState();
}

class _ExploreItemDesignState extends State<ExploreItemDesign> {
  PageController _pageController = PageController(viewportFraction: 0.8);

  List<Color> itemColors = [
    Colors.amber,
    Colors.blue,
    Colors.green,
  ];

  int currentIndex = 1; // Initialize the index
  int totalItems = 3; // Set the total number of items

  bool isFavorite = false;

  @override
  void dispose() {
    _pageController.dispose();
    fetchArtistData();
    super.dispose();
  }

  // Get Skills Data :-

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List makeupType = [];
  List nailsType = [];
  List hairType = [];

  bool skillMakeup = false;
  bool skillHair = false;
  bool skillNails = false;

  Future<void> fetchArtistData() async {
    //collection('artist')[index]['Post'][0]['name'];
    try {
      CollectionReference<Map<String, dynamic>> artistCollection =
          _firestore.collection('Artist');

      QuerySnapshot<Map<String, dynamic>> artistSnapshot =
          await artistCollection.get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> artistDocument
          in artistSnapshot.docs) {
        CollectionReference<Map<String, dynamic>> postsCollection =
            artistDocument.reference.collection('Post');

        QuerySnapshot<Map<String, dynamic>> postsSnapshot =
            await postsCollection.get();

        for (QueryDocumentSnapshot<Map<String, dynamic>> postDocument
            in postsSnapshot.docs) {
          makeupType = postDocument.get('Makeup Type');
          nailsType = postDocument.get('Nails Type');
          hairType = postDocument.get('Hair Type');

          //

          if (makeupType.isNotEmpty) {
            skillMakeup = true;
          }

          if (hairType.isNotEmpty) {
            skillHair = true;
          }

          if (nailsType.isNotEmpty) {
            skillNails = true;
          }

          print(
              'Makeup Type: $makeupType, Nails Type: $nailsType, Hair Type: $hairType');
        }
      }
    } catch (e) {
      print('Error fetching artist data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(fetchArtistData().toString());
    print(makeupType);

    print(skillMakeup);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ExploreDetailsScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          height: 500,
          child: Stack(children: [
            Column(
              children: [
                SizedBox(
                  height: 400,
                  width: 600,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index + 1;
                        });
                      },
                      children: itemColors
                          .map((color) => Container(
                                color: color,
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      skillMakeup
                          ? Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.mackUp),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0, right: 8),
                                  child: Text('Make-up'),
                                ),
                              ],
                            )
                          : Container(),
                      skillHair
                          ? Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.hair),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0, right: 8),
                                  child: Text('Hair'),
                                ),
                              ],
                            )
                          : Container(),
                      skillNails
                          ? Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.nails),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0, right: 8),
                                  child: Text('Nails'),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text('Name')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '0 Reviews',
                          ),
                          Text('Location')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.primaryPink : null,
                ),
                onPressed: () {
                  setState(() {
                    if (isFavorite == true) {
                      isFavorite = false;
                    } else {
                      isFavorite = true;
                    }
                  });
                },
              ),
            ),
            Positioned(
              bottom: 110,
              right: 15,
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    '$currentIndex / ${itemColors.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
