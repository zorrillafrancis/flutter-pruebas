import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../size_config.dart';

class IconBtnWithCounter extends StatelessWidget {
  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;

  const IconBtnWithCounter({
    super.key,
    required this.svgSrc,
    this.numOfItems = 0,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(12)),
          height: getProportionateScreenWidth(46),
          width: getProportionateScreenWidth(46),
          decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1), shape: BoxShape.circle),
          child: SvgPicture.asset(svgSrc),
        ),
        if (numOfItems != 0)
          Positioned(
            right: 0,
            top: -3,
            child: Container(
              height: getProportionateScreenWidth(16),
              width: getProportionateScreenWidth(16),
              decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white)),
              child: Center(
                child: Text(
                  numOfItems.toString(),
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(9),
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}
