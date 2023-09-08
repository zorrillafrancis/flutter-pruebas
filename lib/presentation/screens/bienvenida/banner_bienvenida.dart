import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class banner_bienvenida extends StatelessWidget {
  const banner_bienvenida({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: width * 0.90,
      height: 90,
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(20)),
      child: const Text.rich(
        style: TextStyle(color: Colors.white),
        TextSpan(text: "Bienvenidos\n", children: [
          TextSpan(
              text: "Francis",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
        ]),
      ),
    );
  }
}
