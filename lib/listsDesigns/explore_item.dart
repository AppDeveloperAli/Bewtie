import 'dart:isolate';

import 'package:bewtie/TabScreens/exploreScreens/exploreDetails.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class ExploreItemDesign extends StatefulWidget {
  const ExploreItemDesign({Key? key}) : super(key: key);

  @override
  State<ExploreItemDesign> createState() => _ExploreItemDesignState();
}

class _ExploreItemDesignState extends State<ExploreItemDesign> {
  final List<Color?> itemColors = [
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300]
  ];
  int currentIndex = 1; // Initialize the index

  bool isFavorite = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final itemWidth = 200; // Adjust to your item width
      final pixels = _scrollController.position.pixels;
      final newIndex = (pixels / itemWidth).round();
      if (newIndex != currentIndex) {
        setState(() {
          currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  width: double.infinity,
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount: itemColors.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          width: 400,
                          height: 300,
                          color: itemColors[index % itemColors.length],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.mackUp),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8),
                        child: Text('Make-up'),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.hair),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8),
                        child: Text('Hair'),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.nails),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8),
                        child: Text('Nails'),
                      ),
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
