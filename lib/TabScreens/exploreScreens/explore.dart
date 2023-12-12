import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardicon.dart';
import 'package:bewtie/Components/textSelection.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search1.dart';
import 'package:bewtie/TabScreens/profile/account.dart';
import 'package:bewtie/artistScreens/becomeArtist.dart';
import 'package:bewtie/listsDesigns/explore_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List artists = [];

  @override
  void initState() {
    super.initState();
    getAllArtistIds();
  }

  //

  Future<List<String>> getAllArtistIds() async {
    try {
      CollectionReference<Map<String, dynamic>> artistCollection =
          _firestore.collection('Artist');

      QuerySnapshot<Map<String, dynamic>> artistSnapshot =
          await artistCollection.get();

      return artists = artistSnapshot.docs.map((artistDocument) {
        return artistDocument.id;
      }).toList();
    } catch (e) {
      print('Error fetching artist IDs: $e');
      return [];
    }
  }

  // To Get Data From Posts :-

  List<String> images = [];
  Future<void> fetchPostFields() async {
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
          // Assuming 'images' is a field in the 'Post' collection
          images =
              List.castFrom<dynamic, String>(postDocument.get('images') ?? []);

          // Now, you can use the 'images' list as needed
          print('Images for document ${artistDocument.id}: $images');
        }
      }
    } catch (e) {
      print('Error fetching post fields: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("=======${getAllArtistIds().toString()}");
    print("--------${artists.toString()}");
    print("-------${artists.length}");
    print("++++++++++");
    print(fetchPostFields());
    print("++++++++++");

    print("Length : ${images.length}");

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
                    if (auth.currentUser != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Search1Screen()));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AccountScreen()));
                    }
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
                          Text('Tell us what you\'re after?'),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BecomeArtistScreen()));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
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
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ExploreItemDesign(images: images);
              },
            ),
          ],
        ),
      )),
    );
  }
}

//

// Column(
//             children: [
//               Padding(
//                   padding: const EdgeInsets.only(
//                     top: 10,
//                     left: 15,
//                     right: 15,
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       if (auth.currentUser != null) {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const Search1Screen()));
//                       } else {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const AccountScreen()));
//                       }
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(30.0),
//                         border: Border.all(
//                           color: Colors.black,
//                           width: 1.0,
//                         ),
//                       ),
//                       width: double.infinity,
//                       height: 50,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20, right: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Tell us what you\'re after?'),
//                             SvgPicture.asset(
//                               'assets/svg/Explore-Icon-Black.svg',
//                               height: 20,
//                               width: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )),
//               Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       if (auth.currentUser != null) {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const BecomeArtistScreen()));
//                       } else {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const AccountScreen()));
//                       }
//                     },
//                     child: MyCardButton(
//                       title: 'Become a Bewtie Artist',
//                     ),
//                   )),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const Text('Sort by'),
//                   ClickableText(
//                     text: "location",
//                   ),
//                   const Text('/'),
//                   ClickableText(
//                     text: "highest price",
//                   ),
//                   const Text('/'),
//                   ClickableText(
//                     text: "lowest price",
//                   ),
//                 ],
//               ),
//               ListView.builder(
//                 itemCount: 3,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return const ExploreItemDesign();
//                 },
//               )
//             ],
//           ),

//

// StreamBuilder(
//           stream: _firestore.collection('Artist').snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             }

//             print('------${snapshot}');

//             var artists = snapshot.data!.docs;
//             print("-------$artists");
//             print("=======${artists.length}");

//             return ListView.builder(
//               itemCount: artists.length,
//               itemBuilder: (context, index) {
//                 var artist = artists[index];

//                 return ListTile(
//                   title: Text('User UID: ${artist.id}'),
//                   subtitle: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('Artist')
//                         .doc(artist.id)
//                         .collection('Post')
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const CircularProgressIndicator();
//                       }

//                       var posts = snapshot.data!.docs;

//                       print("+++${posts.toString()}");
//                       print("+++${posts.length}");

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Posts:'),
//                           for (var post in posts) Text('Post UID: ${post.id}'),
//                         ],
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//         ),
