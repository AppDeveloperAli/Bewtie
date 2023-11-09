import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PickImageCardWidget extends StatelessWidget {
  bool? isPicked;
  PickImageCardWidget({super.key, required this.isPicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: isPicked! ? Colors.grey[400] : Colors.white),
        child: Center(
            child: isPicked!
                ? SvgPicture.asset('assets/svg/Add-Image-Icon-White.svg')
                : SvgPicture.asset('assets/svg/Add-Image-Icon-White.svg')),
      ),
    );
  }
}
