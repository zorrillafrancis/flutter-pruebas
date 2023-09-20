import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class TotalWidget extends StatelessWidget {
  final double total;
  final double subtotal;
  final double itbis;
  final double descuento;
  const TotalWidget(
      {super.key,
      required this.total,
      required this.subtotal,
      required this.itbis,
      required this.descuento});

  @override
  Widget build(BuildContext context) {
    Util util = Util();

    if (total > 0) {
      return Container(
          height: 120,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.15))
          ]),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  util.getCurrency(total),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              const Spacer(),
              Container(
                height: 60,
                width: 150,
                alignment: Alignment.center,
                child: const Text(
                  "Ver Detalle",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueAccent),
                ),
              ),
            ],
          ));
    } else {
      return Text('');
    }
  }
}
