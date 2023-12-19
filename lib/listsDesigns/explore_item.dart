import 'package:bewtie/TabScreens/exploreScreens/exploreDetails.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExploreItemDesign extends StatefulWidget {
  String? location,
      firstName,
      lastName,
      artImage,
      bio,
      postUid,
      reviewCount,
      price;
  final List<dynamic> imageLinks;
  List<dynamic> avail;
  List<dynamic> hair;
  List<dynamic> mackup;
  List<dynamic> nails;

  ExploreItemDesign(
      {Key? key,
      required this.price,
      required this.location,
      required this.firstName,
      required this.lastName,
      required this.artImage,
      required this.imageLinks,
      required this.bio,
      required this.avail,
      required this.hair,
      required this.mackup,
      required this.nails,
      required this.postUid,
      required this.reviewCount})
      : super(key: key);

  @override
  State<ExploreItemDesign> createState() => _ExploreItemDesignState();
}

class _ExploreItemDesignState extends State<ExploreItemDesign> {
  final PageController _pageController = PageController(viewportFraction: 1);

  List<Color> itemColors = [
    Colors.amber,
    Colors.blue,
    Colors.green,
  ];

  int currentIndex = 1;

  bool isFavorite = false;

  @override
  void initState() {
    _pageController.initialPage;
    checkInitialFavoriteStatus();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List makeupType = [];
  List nailsType = [];
  List hairType = [];

  bool skillMakeup = false;
  bool skillHair = false;
  bool skillNails = false;

  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('Users');

  FirebaseAuth _auth = FirebaseAuth.instance;
  String getCurrentUserId() {
    User? user = _auth.currentUser;
    return user!.uid;
  }

  void checkInitialFavoriteStatus() async {
    String documentId = getCurrentUserId();
    String postUid = widget.postUid.toString();

    DocumentSnapshot doc = await _collection.doc(documentId).get();
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    List<dynamic> favourites = data?['favourite'] ?? [];
    bool isFavourite = favourites.contains(postUid);

    setState(() {
      isFavorite = isFavourite;
    });
  }

  int convertStringToInteger(String stringValue) {
    double doubleValue = double.tryParse(stringValue) ?? 0.0;
    int integerValue = doubleValue.toInt();
    return integerValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ExploreDetailsScreen(
                  lastName: widget.lastName,
                  firstName: widget.firstName,
                  location: widget.location,
                  artImage: widget.artImage,
                  bio: widget.bio,
                  imageList: widget.imageLinks,
                  avialibilty: widget.avail,
                  hair: widget.hair,
                  mackup: widget.mackup,
                  nails: widget.nails,
                  postUid: widget.postUid.toString(),
                  reviewCount: widget.reviewCount,
                  price: widget.price,
                )));
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
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
                      children: widget.imageLinks
                          .map((imageUrl) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      makeupType.isEmpty
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
                      hairType.isEmpty
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
                      nailsType.isEmpty
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
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            convertStringToInteger(widget.price.toString())
                                .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                              '${widget.firstName.toString()} ${widget.lastName.toString()}')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${widget.reviewCount} Reviews',
                          ),
                          Text(widget.location.toString())
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
                onPressed: () async {
                  toggleFavouriteStatus();
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
                    '$currentIndex / ${widget.imageLinks.length}',
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

  void toggleFavouriteStatus() async {
    String documentId = getCurrentUserId();
    String postUid = widget.postUid.toString();

    DocumentSnapshot doc = await _collection.doc(documentId).get();
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    List<dynamic> favourites = data?['favourite'] ?? [];
    bool isFavourite = favourites.contains(postUid);

    if (isFavourite) {
      await _collection.doc(documentId).update({
        'favourite': FieldValue.arrayRemove([postUid]),
      });
    } else {
      await _collection.doc(documentId).update({
        'favourite': FieldValue.arrayUnion([postUid]),
      });
    }

    setState(() {
      isFavorite = !isFavourite;
    });
  }
}
