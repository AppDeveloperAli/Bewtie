// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class TransactonArtist extends StatelessWidget {
  const TransactonArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
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
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Transactions',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Month / Year',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [item(), item()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [item(), item()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [item(), item()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [item(), item()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [item(), item()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [item(), item()],
              ),
            )
          ],
        ),
      )),
    );
  }

  Column item() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Month / Year',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'Name of client',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'Payment method',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'Date',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'Paid',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'Service',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'Location',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'Download pdf',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primaryPink,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primaryPink, // Set the underline color
          ),
        ),
      ],
    );
  }
}
