// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:flutter/material.dart';

class DescribeScreen extends StatefulWidget {
  const DescribeScreen({super.key});

  @override
  State<DescribeScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<DescribeScreen> {
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Describe yourself',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Start typing...',
                        hintStyle: TextStyle(color: Colors.white),
                        helperStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      maxLines: 50,
                    ),
                  ),
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
      )),
    );
  }
}
