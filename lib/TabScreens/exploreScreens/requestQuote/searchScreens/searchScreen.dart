import 'package:bewtie/landingPage1.dart';
import 'package:bewtie/listsDesigns/explore_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<String> typeMakeup;
  final List<String> typeHair;
  final List<String> typeNails;
  final Map<String, double> makeupPrices;
  final Map<String, double> hairPrices;
  final Map<String, double> nailsPrices;
  String? title, result, date, location;

  SearchScreen(
      {super.key,
      required this.typeMakeup,
      required this.typeHair,
      required this.typeNails,
      required this.makeupPrices,
      required this.hairPrices,
      required this.nailsPrices,
      required this.title,
      required this.result,
      required this.date,
      required this.location});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool doesFieldExist(Map<String, dynamic>? data, String fieldName) {
    return data != null &&
        data.containsKey(fieldName) &&
        data[fieldName] != null &&
        (data[fieldName] as List).isNotEmpty;
  }

  String processArrayString(String input) {
    // Replace "[" with ""
    input = input.replaceAll('[', '');

    // Replace "]" with ""
    input = input.replaceAll(']', '');

    // Remove extra spaces
    input = input.trim();

    return input.isNotEmpty ? '($input)' : '';
  }

  @override
  Widget build(BuildContext context) {
    String originalString =
        '${widget.typeHair.toString()} ${widget.typeMakeup.toString()} ${widget.typeNails.toString()}';
    String processedString = processArrayString(originalString);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()),
                  (route) => false,
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.close,
                  size: 40,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Results for $processedString',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          StreamBuilder(
            stream: _firestore.collection('Post').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              var documents = (snapshot.data as QuerySnapshot).docs;

              // Filter documents based on your criteria
              var filteredDocuments = documents.where((doc) {
                var data = doc.data() as Map<String, dynamic>?;

                return doesFieldExist(data, 'Makeup Type') ||
                    doesFieldExist(data, 'Hair Type') ||
                    doesFieldExist(data, 'Nails Type');
              }).toList();

              return FutureBuilder<List<List<DocumentSnapshot>>>(
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

                  return ListView.builder(
                    itemCount: posts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FutureBuilder<QuerySnapshot>(
                        future: posts[index]
                            .reference
                            .collection('PostReviews')
                            .get(),
                        builder: (context, subCollectionSnapshot) {
                          if (subCollectionSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (subCollectionSnapshot.hasError) {
                            return Text(
                                'Error: ${subCollectionSnapshot.error}');
                          }

                          List<DocumentSnapshot> subCollectionDocuments =
                              subCollectionSnapshot.data?.docs ?? [];

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
              );
            },
          ),
        ],
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
