import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class FacturaTotal extends StatefulWidget {
  late double? total;
  late double? subtotal;
  late double? itbis;
  late double? descuento;
  FacturaTotal(
      {super.key,
      required this.total,
      required this.subtotal,
      required this.itbis,
      required this.descuento});

  @override
  State<FacturaTotal> createState() => _FacturaTotalState();
}

class _FacturaTotalState extends State<FacturaTotal> {
  @override
  Widget build(BuildContext context) {
    Util util = Util();

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
                util.getCurrency(widget.total!),
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
  }
}
