import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardicon.dart';
import 'package:bewtie/Components/textSelection.dart';
import 'package:bewtie/listsDesigns/explore_item.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyCardIcon(
                    hintText: 'Tell us what you"re after?',
                    iconData: Icons.search,
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyCardButton(
                    title: 'Become a Bewtie Artist',
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
