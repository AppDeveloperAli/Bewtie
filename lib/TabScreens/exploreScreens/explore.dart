import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textSelection.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search1.dart';
import 'package:bewtie/TabScreens/profile/account.dart';
import 'package:bewtie/artistScreens/becomeArtist.dart';
import 'package:bewtie/listsDesigns/explore_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('Post');

  final CollectionReference otherCollection =
      FirebaseFirestore.instance.collection('Artist_Data');

  Future<List<List<DocumentSnapshot>>> getPosts() async {
    List<Future<QuerySnapshot>> futures = [
      postCollection.get(),
      otherCollection.get(),
    ];

    List<QuerySnapshot> results = await Future.wait(futures);

    return results.map((querySnapshot) => querySnapshot.docs).toList();
  }

  bool isLoading = false;

  String? countryTitle;

  FirebaseAuth _auth = FirebaseAuth.instance;
  String getCurrentUserId() {
    User? user = _auth.currentUser;
    return user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const Search1Screen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tell us what you\'re after?'),
                            SvgPicture.asset(
                              'assets/svg/Explore-Icon-Black.svg',
                              height: 20,
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      if (auth.currentUser != null) {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const BecomeArtistScreen()));
                      } else {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const AccountScreen()));
                      }
                    },
                    child: MyCardButton(
                      title: 'Become a Bewtie Artist',
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Sort by'),
                  ClickableText(
                    text: "location",
                  ),
                  const Text('/'),
                  ClickableText(
                    text: "highest price",
                  ),
                  const Text('/'),
                  ClickableText(
                    text: "lowest price",
                  ),
                ],
              ),
              FutureBuilder<List<List<DocumentSnapshot>>>(
                future: getPosts(),
                builder: (
                  context,
                  AsyncSnapshot<List<List<DocumentSnapshot>>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  List<List<DocumentSnapshot>> allPosts = snapshot.data ?? [];
                  List<DocumentSnapshot> posts = allPosts[0];
                  List<DocumentSnapshot> artists = allPosts[1];

                  return FutureBuilder<QuerySnapshot>(
                    future: posts[0].reference.collection('PostReviews').get(),
                    builder: (context, subCollectionSnapshot) {
                      if (subCollectionSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (subCollectionSnapshot.hasError) {
                        return Text('Error: ${subCollectionSnapshot.error}');
                      }

                      List<DocumentSnapshot> subCollectionDocuments =
                          subCollectionSnapshot.data?.docs ?? [];

                      return ListView.builder(
                        itemCount: posts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ExploreItemDesign(
                            location: getValue(
                                    posts[index]
                                        as QueryDocumentSnapshot<Object?>,
                                    'Location')
                                ?.toString(),
                            firstName: getValue(
                              artists[index] as QueryDocumentSnapshot<Object?>,
                              'first_name',
                            ).toString(),
                            lastName: getValue(
                                    artists[index]
                                        as QueryDocumentSnapshot<Object?>,
                                    'last_name')
                                ?.toString(),
                            imageLinks: getArrayValue(
                                posts[index] as QueryDocumentSnapshot<Object?>,
                                'images'),
                            artImage: getValue(
                                    artists[index]
                                        as QueryDocumentSnapshot<Object?>,
                                    'profileimage')
                                ?.toString(),
                            bio: getValue(
                                    artists[index]
                                        as QueryDocumentSnapshot<Object?>,
                                    'describe')
                                ?.toString(),
                            avail: getArrayValue(
                                posts[index] as QueryDocumentSnapshot<Object?>,
                                'availability'),
                            hair: getArrayValue(
                                posts[index] as QueryDocumentSnapshot<Object?>,
                                'Hair Type'),
                            mackup: getArrayValue(
                                posts[index] as QueryDocumentSnapshot<Object?>,
                                'Makeup Type'),
                            nails: getArrayValue(
                                posts[index] as QueryDocumentSnapshot<Object?>,
                                'Nails Type'),
                            postUid: getValue(
                                    posts[index]
                                        as QueryDocumentSnapshot<Object?>,
                                    'UID')
                                ?.toString(),
                            reviewCount:
                                subCollectionDocuments.length.toString(),
                            price: getValue(
                                    posts[index]
                                        as QueryDocumentSnapshot<Object?>,
                                    'Package Total')
                                ?.toString(),
                          );
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic getValue(QueryDocumentSnapshot<Object?> document, String key) {
    final data = document.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey(key)) {
      return data[key];
    }

    return ''; // Replace '' with the default value you want to use when the key is not found or document is null
  }

  List<dynamic>? getArrayValue(QueryDocumentSnapshot document, String key) {
    final data = document.data()
        as Map<String, dynamic>?; // Explicit cast to Map<String, dynamic>
    if (data != null) {
      final value = data[key];
      if (value is List<dynamic>) {
        return List<dynamic>.from(value);
      }
    }
    return null;
  }
}
