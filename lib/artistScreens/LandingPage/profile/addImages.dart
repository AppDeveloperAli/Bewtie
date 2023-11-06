import 'package:bewtie/Components/pickImage.dart';
import 'package:flutter/material.dart';

class AddIMagesArtist extends StatelessWidget {
  const AddIMagesArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
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
            PickImageCardWidget(isPicked: true),
          ],
        ),
      ),
    );
  }
}
