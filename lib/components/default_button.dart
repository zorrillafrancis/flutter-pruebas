import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function() press;

  const DefaultButton({
    super.key,
    required this.text,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18))),
              backgroundColor: const MaterialStatePropertyAll(kPrimaryColor),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 18, color: Colors.white))),
          onPressed: press,
          child: Text(
            text,
          )),
    );
  }
}
