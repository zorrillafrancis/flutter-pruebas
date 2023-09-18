import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/rounded_icon_btn.dart';
import '../../utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String rating;

  CustomAppBar(this.rating);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        RoundededIconBtn(
            iconData: Icons.arrow_back_ios,
            press: () => Navigator.pop(context)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Row(
            children: [
              Text(
                rating,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset('lib/assets/icons/Star Icon.svg')
            ],
          ),
        )
      ]),
    ));
  }
}
