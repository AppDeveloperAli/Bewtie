import 'package:bewtie/TabScreens/exploreScreens/exploreDetails.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class ExploreItemDesign extends StatefulWidget {
  const ExploreItemDesign({super.key});

  @override
  State<ExploreItemDesign> createState() => _ExploreItemDesignState();
}

class _ExploreItemDesignState extends State<ExploreItemDesign> {
  List<String> items = List.generate(3, (index) => "Item $index");
  List<bool> isFavorite = List.filled(3, false);

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
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ItemCard(
                      title: items[index],
                      currentIndex: (index + 1).toString(),
                      total: items.length.toString(),
                      isFavorite: isFavorite[index],
                      onFavoritePressed: () {
                        setState(() {
                          isFavorite[index] = !isFavorite[index];
                        });
                      },
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
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title, currentIndex, total;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  ItemCard({
    required this.title,
    required this.currentIndex,
    required this.total,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.all(8),
      child: Card(
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.primaryPink : null,
                ),
                onPressed: onFavoritePressed,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    '$currentIndex / $total',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
