import 'package:flutter/material.dart';
import 'package:mi_app_01/utils/size_config.dart';

class RoundededIconBtn extends StatelessWidget {
  final IconData iconData;
  final GestureTapCallback press;

  const RoundededIconBtn({
    super.key,
    required this.iconData,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: getProportionateScreenWidth(40),
          width: getProportionateScreenWidth(40),
          child: ElevatedButton.icon(
            label: const Text(''),
            icon: Icon(iconData),
            onPressed: press,
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              padding: const EdgeInsets.only(left: 10),
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          )),
    );
  }
}
