import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_app_01/models/facturasDetalleModel.dart';
import 'package:mi_app_01/pages/facturas/facturaDetalle.dart';
import 'package:mi_app_01/size_config.dart';
import 'package:mi_app_01/src/provider/chatProvider.dart';
import 'package:provider/provider.dart';

int value = 100;

class TotalWidget extends StatefulWidget {
  final double? valor;

  const TotalWidget({super.key, required this.valor});

  @override
  State<TotalWidget> createState() => _TotalWidgetState();
}

class _TotalWidgetState extends State<TotalWidget> {
  @override
  void initState() {
    super.initState();
    print(widget.valor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15))
        ]),
        child: Row(
          children: [
            SizedBox(
                height: 50,
                width: 100,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text('1,200.00'),
                )),
            Spacer(),
            Container(
              height: 60,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "RD25,000.00",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
