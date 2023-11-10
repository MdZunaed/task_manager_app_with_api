import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BodyBackground extends StatelessWidget {
  final Widget child;

  const BodyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset("assets/images/background.svg",
            height: double.infinity, width: double.infinity, fit: BoxFit.cover),
        child
      ],
    );
  }
}
