import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:bewtie/Components/pickImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddIMagesArtist extends StatelessWidget {
  const AddIMagesArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Add images / videos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: PickImageCardWidget(isPicked: true)),
                      Expanded(child: PickImageCardWidget(isPicked: true)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: PickImageCardWidget(isPicked: true)),
                      Expanded(
                        child: Container(
                          width: 200,
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.black),
                          child: Center(
                              child: SvgPicture.asset(
                                  'assets/svg/Add-Image-Icon-White.svg')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              MyTextCardArtist(title: 'Cancel', fontSize: 18))),
                  Expanded(child: MyCardButton(title: 'Send')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
