import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';

class SocialCard extends StatelessWidget {
  final String icon;
  const SocialCard({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        decoration: const BoxDecoration(
            color: Color(0XFFF5F6F9), shape: BoxShape.circle),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
