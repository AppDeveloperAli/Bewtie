// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/TabScreens/exploreScreens/leaveReview.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search1.dart';
import 'package:bewtie/TabScreens/exploreScreens/reviews.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class ExploreDetailsScreen extends StatefulWidget {
  String? firstName, lastName, location, artImage, Bio;
  List<dynamic> imageList;
  ExploreDetailsScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.location,
      required this.artImage,
      required this.Bio,
      required this.imageList});

  @override
  State<ExploreDetailsScreen> createState() => _ExploreDetailsScreenState();
}

class _ExploreDetailsScreenState extends State<ExploreDetailsScreen> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
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
                      child: PageView(
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
                    child: Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          '1 / 1',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                      width: 60, // Adjust the size as needed
                      height: 60, // Adjust the size as needed
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
                          'Price',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Service ',
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '0 Reviews',
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
                    Text(
                      'Monday -',
                    ),
                    Text(
                      'Tuesday -',
                    ),
                    Text(
                      'Wednesday -',
                    ),
                    Text(
                      'Thursday -',
                    ),
                    Text(
                      'Friday -',
                    ),
                    Text(
                      'Saturday -',
                    ),
                    Text(
                      'Sunday -',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Bio : ${widget.Bio}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: MyTextCard(title: 'Send a message', fontSize: 18),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Search1Screen()));
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '0 Reviews',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 60, // Adjust the size as needed
                                height: 60, // Adjust the size as needed
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Name or reviewer',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Date',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text('xxxxxxxxx'),
                            )
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ReviewsScreen()));
                              },
                              child: MyTextCard(
                                  title: 'Show all reviews', fontSize: 15),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const LeaveReviewScreen()));
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
}
