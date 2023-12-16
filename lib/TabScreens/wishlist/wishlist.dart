import 'package:bewtie/landingPage1.dart';
import 'package:bewtie/listsDesigns/explore_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late CollectionReference usersCollection;
  FirebaseAuth auth = FirebaseAuth.instance;
  late CollectionReference postCollection;
  late CollectionReference otherCollection;
  List<Map<String, dynamic>> matchingDocumentsData = [];

  @override
  void initState() {
    super.initState();
    usersCollection = FirebaseFirestore.instance.collection('Users');
    postCollection = FirebaseFirestore.instance.collection('Post');
    otherCollection = FirebaseFirestore.instance.collection('Artist_Data');
  }

  Future<List<List<DocumentSnapshot>>> fetchData() async {
    String currentUserId = auth.currentUser!.uid;

    try {
      DocumentSnapshot userDoc = await usersCollection.doc(currentUserId).get();
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('favourite')) {
        List<dynamic> favouriteArray = userData['favourite'];

        List<String> validDocumentIds = favouriteArray
            .where(
                (documentId) => documentId is String && documentId.isNotEmpty)
            .cast<String>()
            .toList();

        List<DocumentSnapshot> matchingDocuments = await Future.wait(
          validDocumentIds
              .map((documentId) => postCollection.doc(documentId).get()),
        );

        List<DocumentSnapshot> matchingArtists = await Future.wait(
          validDocumentIds
              .map((documentId) => otherCollection.doc(documentId).get()),
        );

        matchingDocumentsData = matchingDocuments
            .where((document) => document.exists)
            .map((document) => document.data() as Map<String, dynamic>)
            .toList();

        print('Number of Matching Documents: ${matchingDocumentsData.length}');

        return [matchingDocuments, matchingArtists];
      } else {
        print('User data or favourite array not found.');
        return [[], []];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [[], []];
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LandingPage()),
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
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
              ),
              child: Text(
                'Wishlists',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            FutureBuilder<List<List<DocumentSnapshot>>>(
              future: fetchData(),
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

                return posts.isEmpty
                    ? const Expanded(
                        child:
                            Center(child: Text('Nothing to show in Wishlists')))
                    : FutureBuilder<QuerySnapshot>(
                        future: posts.isNotEmpty
                            ? posts[0].reference.collection('PostReviews').get()
                            : null,
                        builder: (context, subCollectionSnapshot) {
                          if (subCollectionSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (subCollectionSnapshot.hasError == true) {
                            return Text(
                                'Error: ${subCollectionSnapshot.error}');
                          }

                          List<DocumentSnapshot> subCollectionDocuments =
                              subCollectionSnapshot.data?.docs ?? [];

                          return ListView.builder(
                            itemCount: posts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ExploreItemDesign(
                                location: posts[index]['Location'].toString(),
                                firstName:
                                    artists[index]['first_name'].toString(),
                                lastName:
                                    artists[index]['last_name'].toString(),
                                imageLinks: posts[index]['images'],
                                artImage: artists[index]['profileimage'],
                                bio: artists[index]['describe'],
                                avail: posts[index]['availability'],
                                hair: posts[index]['Hair Type'],
                                mackup: posts[index]['Makeup Type'],
                                nails: posts[index]['Nails Type'],
                                postUid: posts[index]['UID'],
                                reviewCount:
                                    subCollectionDocuments.length.toString(),
                              );
                            },
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
