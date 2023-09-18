import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_app_01/components/rounded_icon_btn.dart';
import 'package:mi_app_01/pages/product/product_detail_body.dart';
import 'package:mi_app_01/utils/size_config.dart';

class DetailScreen extends StatelessWidget implements PreferredSizeWidget {
  static String routeName = "/details";

  const DetailScreen({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: MyAppBar(
        "5.6",
      ),
      body: ProductDetailBody(),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String rating;

  MyAppBar(this.rating);

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
                style: TextStyle(fontWeight: FontWeight.w600),
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
