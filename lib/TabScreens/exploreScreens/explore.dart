import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardicon.dart';
import 'package:bewtie/Components/textSelection.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/searchScreens/search1.dart';
import 'package:bewtie/TabScreens/profile/account.dart';
import 'package:bewtie/artistScreens/becomeArtist.dart';
import 'package:bewtie/listsDesigns/explore_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

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
                  return const ExploreItemDesign();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
