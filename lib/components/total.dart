import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_app_01/models/facturasDetalleModel.dart';
import 'package:mi_app_01/pages/facturas/facturaDetalle.dart';
import 'package:mi_app_01/size_config.dart';
import 'package:mi_app_01/src/provider/chatProvider.dart';
import 'package:provider/provider.dart';

int value = 100;

class TotalWidget extends StatefulWidget {
  final int valor;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Total',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                Spacer(),
                Container(
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sub-Total'),
                            Text(widget.valor.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('data'),
                            Text('data'),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}
