// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/TabScreens/chatScreens/chatScreen.dart';
import 'package:bewtie/TabScreens/exploreScreens/leaveReview.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/quoteScreens/requestQuote.dart';
import 'package:bewtie/TabScreens/exploreScreens/reviews.dart';
import 'package:bewtie/TabScreens/profile/account.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ExploreDetailsScreen extends StatefulWidget {
  String? firstName,
      lastName,
      location,
      artImage,
      bio,
      postUid,
      reviewCount,
      price;
  List<dynamic> imageList;
  List<dynamic> avialibilty;
  List<dynamic> hair;
  List<dynamic> mackup;
  List<dynamic> nails;

  ExploreDetailsScreen(
      {super.key,
      required this.firstName,
      required this.price,
      required this.lastName,
      required this.location,
      required this.artImage,
      required this.bio,
      required this.imageList,
      required this.avialibilty,
      required this.hair,
      required this.mackup,
      required this.nails,
      required this.postUid,
      required this.reviewCount});

  @override
  State<ExploreDetailsScreen> createState() => _ExploreDetailsScreenState();
}

class _ExploreDetailsScreenState extends State<ExploreDetailsScreen> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    print(widget.nails);

    print(widget.hair);

    print(widget.mackup);

    print("-----${widget.postUid}");

    Map<String, String> availabilityStatus =
        getAvailabilityStatus(widget.avialibilty);

    int convertStringToInteger(String stringValue) {
      double doubleValue = double.tryParse(stringValue) ?? 0.0;
      int integerValue = doubleValue.toInt();
      return integerValue;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                      child: widget.imageList.isEmpty
                          ? SvgPicture.asset('assets/images/B Mark.svg')
                          : PageView(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index + 1;
                                });
                              },
                              children: widget.imageList
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
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: widget.imageList.isEmpty
                        ? Container()
                        : Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                '$currentIndex / ${widget.imageList.length}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.artImage.toString()),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${widget.firstName} ${widget.lastName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          convertStringToInteger(widget.price.toString())
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Service : ${checkServices(widget.hair, 'Hairs')} ${checkServices(widget.nails, ' - Nails')} ${checkServices(widget.mackup, ' - Makeup ')}',
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.reviewCount} Reviews',
                        ),
                        Text(
                          widget.location.toString(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Availability',
                    ),
                    buildAvailabilityText('Monday -',
                        availabilityStatus['Mon'] ?? 'not available'),
                    buildAvailabilityText('Tuesday -',
                        availabilityStatus['Tue'] ?? 'not available'),
                    buildAvailabilityText('Wednesday -',
                        availabilityStatus['Wed'] ?? 'not available'),
                    buildAvailabilityText('Thursday -',
                        availabilityStatus['Thu'] ?? 'not available'),
                    buildAvailabilityText('Friday -',
                        availabilityStatus['Fri'] ?? 'not available'),
                    buildAvailabilityText('Saturday -',
                        availabilityStatus['Sat'] ?? 'not available'),
                    buildAvailabilityText('Sunday -',
                        availabilityStatus['Sun'] ?? 'not available'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Bio : ${widget.bio}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //
                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(uid: widget.postUid.toString()),
                            ));
                          },
                          child: MyTextCard(
                              title: 'Send a message', fontSize: 18)),
                    ),

                    GestureDetector(
                        onTap: () {
                          if (auth.currentUser != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RequestQuoteScreen(
                                      hair: widget.hair,
                                      nails: widget.nails,
                                      mack: widget.mackup,
                                      price: widget.price,
                                      location: widget.location,
                                      postUid: widget.postUid,
                                      name:
                                          '${widget.firstName} ${widget.lastName}',
                                    )));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AccountScreen(),
                            ));
                          }
                        },
                        child: MyCardButton(title: 'Request a quote')),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: double.infinity,
                        height: 0.5,
                        color: AppColors.lightPink,
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Post')
                            .doc(widget.postUid)
                            .collection('PostReviews')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          var data = snapshot.data!.docs;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${data.length} Reviews',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var review = data[index];
                                  Timestamp timestamp =
                                      data[index]['timestamp'];
                                  DateTime dateTime = timestamp.toDate();
                                  String formattedDate =
                                      DateFormat('yyyy/MM/dd - HH:mm:ss')
                                          .format(dateTime);

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                                review['userImage']),
                                            backgroundColor: Colors.transparent,
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          review['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          formattedDate,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          review['text'],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ReviewsScreen(
                                          postUid: widget.postUid!,
                                        )));
                              },
                              child: MyTextCard(
                                  title: 'Show all reviews', fontSize: 15),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LeaveReviewScreen(
                                            postUID: widget.postUid.toString(),
                                          )));
                                },
                                child: MyCardButton(title: 'Leave a review')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAvailabilityText(String day, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day),
        Text(status),
      ],
    );
  }

  Map<String, String> getAvailabilityStatus(List<dynamic> weekdays) {
    Map<String, String> availability = {
      'Sun': 'Not Available',
      'Mon': 'Not Available',
      'Tue': 'Not Available',
      'Wed': 'Not Available',
      'Thu': 'Not Available',
      'Fri': 'Not Available',
      'Sat': 'Not Available',
    };

    for (dynamic day in weekdays) {
      String dayString = day.toString();
      if (availability.containsKey(dayString)) {
        availability[dayString] = 'Available';
      }
    }

    return availability;
  }

  checkServices(List<dynamic> list, String serviceText) {
    String available = '';
    if (list.isNotEmpty) {
      return available = serviceText;
    } else {
      return available = '';
    }
  }
}
