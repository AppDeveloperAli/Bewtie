import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePayment extends StatefulWidget {
  final ValueChanged<String?> onPaymentMethodChanged;

  const ChangePayment({Key? key, required this.onPaymentMethodChanged})
      : super(key: key);

  @override
  State<ChangePayment> createState() => _ChangePaymentState();
}

class _ChangePaymentState extends State<ChangePayment> {
  List<Map<String, dynamic>> paymentMethods = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  int selectedPaymentIndex = -1;
  String selectedValue = '';

  void _handlePaymentMethodChange(String selectedMethod) {
    widget.onPaymentMethodChanged(selectedMethod);
    Navigator.pop(context, selectedMethod);
  }

  @override
  void initState() {
    super.initState();
    fetchPaymentMethods();
  }

  Future<void> fetchPaymentMethods() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        List<dynamic>? payments = snapshot.data()!['payments'];

        if (payments != null && payments is List) {
          paymentMethods = List<Map<String, dynamic>>.from(
            payments
                .map((dynamic payment) => Map<String, dynamic>.from(payment)),
          );
          setState(() {});
        }
      }
    } catch (e) {
      print('Error fetching payment methods: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _handlePaymentMethodChange(selectedValue);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
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
            paymentMethods.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text('No Payment Method Found!'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: paymentMethods.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CustomRadioButton(
                            labelText: paymentMethods[index]['cardName'] ?? '',
                            isSelected: selectedPaymentIndex == index,
                            onTap: () {
                              setState(() {
                                selectedPaymentIndex = index;
                              });
                            },
                            onSelectedTextChanged: (selectedText) {
                              setState(() {
                                selectedValue = selectedText;
                              });
                            },
                          ),
                          Container(
                            width: double.infinity,
                            height: 0.5,
                            color: AppColors.primaryPink,
                          ),
                        ],
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class CustomRadioButton extends StatefulWidget {
  final String labelText;
  final bool isSelected;
  final VoidCallback onTap;
  final Function(String) onSelectedTextChanged;

  CustomRadioButton({
    required this.labelText,
    required this.isSelected,
    required this.onTap,
    required this.onSelectedTextChanged,
  });

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        widget.onSelectedTextChanged(widget.labelText);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.labelText),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.isSelected ? Colors.black : Colors.grey,
                ),
              ),
              child: widget.isSelected
                  ? Center(
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
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
