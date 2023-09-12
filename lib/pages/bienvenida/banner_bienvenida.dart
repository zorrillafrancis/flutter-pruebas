import 'package:flutter/material.dart';

class BannerBienvenida extends StatelessWidget {
  final double width;
  final String? name;

  const BannerBienvenida({
    super.key,
    required this.width,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: width * 0.90,
      height: 90,
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(20)),
      child: Text.rich(
        style: const TextStyle(color: Colors.white),
        TextSpan(text: "Bienvenidos\n", children: [
          TextSpan(
              text: name.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
        ]),
      ),
    );
  }
}
