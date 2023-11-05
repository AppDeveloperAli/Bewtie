import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class ChangePayment extends StatefulWidget {
  const ChangePayment({super.key});

  @override
  State<ChangePayment> createState() => _QuoteScreen2State();
}

class _QuoteScreen2State extends State<ChangePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Change payment method',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            height: 0.5,
            color: AppColors.primaryPink,
          ),
          CustomRadioButton(
            labelText: 'Apple Pay',
            isSelected: true,
            onTap: () {
              // Handle the selection logic here
            },
          ),
          Container(
            width: double.infinity,
            height: 0.5,
            color: AppColors.primaryPink,
          ),
          CustomRadioButton(
            labelText: '+ Add credit or debit card',
            isSelected: false,
            onTap: () {
              // Handle the selection logic here
            },
          ),
          Container(
            width: double.infinity,
            height: 0.5,
            color: AppColors.primaryPink,
          ),
          CustomRadioButton(
            labelText: 'Paypal',
            isSelected: false,
            onTap: () {
              // Handle the selection logic here
            },
          ),
        ],
      )),
    );
  }
}

class CustomRadioButton extends StatefulWidget {
  final String labelText;
  final bool isSelected;
  final VoidCallback onTap;

  CustomRadioButton(
      {required this.labelText, this.isSelected = false, required this.onTap});

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.labelText),
            SizedBox(
                width: 8), // Adjust the spacing between the dot and the text

            Container(
              width: 24, // Adjust the size of the dot as needed
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.isSelected
                      ? Colors.black
                      : Colors.grey, // Change border color when selected
                ),
              ),
              child: widget.isSelected
                  ? Center(
                      child: Container(
                        width:
                            16, // Adjust the size of the inner color as needed
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Colors.black, // Change inner color when selected
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
