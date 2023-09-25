import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_app_01/pages/factura_detalle/factura_detalle.dart';
import '../../components/default_button.dart';
import '../../components/loading_list.dart';
import '../../models/facturasM.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class FacturaListadoBody1 extends StatefulWidget {
  const FacturaListadoBody1({super.key});

  @override
  State<FacturaListadoBody1> createState() => _FacturaListadoBody1State();
}

class _FacturaListadoBody1State extends State<FacturaListadoBody1> {
  @override
  Widget build(BuildContext context) {
    return FacturasListadoBody();
  }
}

class FacturasListadoBody extends StatefulWidget {
  const FacturasListadoBody({super.key});

  @override
  State<FacturasListadoBody> createState() => _FacturasListadoState();
}

class _FacturasListadoState extends State<FacturasListadoBody> {
  Util util = Util();
  Future<List<Facturas>>? listData;
  List<Facturas> dataFactura = [];
  String numero_factura = "";
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtDateFrom = TextEditingController();
  TextEditingController txtDateTo = TextEditingController();
  String dateFrom =
      DateFormat('yyyy-MM-ddT00:00:00.000').format(DateTime.now());
  String dateTo = DateFormat('yyyy-MM-ddT23:59:59.999').format(DateTime.now());

  Future<List<Facturas>> getFacturas() async {
    List<Facturas> dataFactura = [];

    String url = "${Environment.apiUrl}/Facturas?pkidEmpresa=1&isCliente=0";

    var body = {
      "numero_factura": numero_factura,
      "fechaDesde": dateFrom,
      "fechaHasta": dateTo
    };

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      try {
        String body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);

        for (dynamic item in jsonData['value']) {
          Facturas f = Facturas(
              item['id'],
              item['numeroFactura'],
              item['fecha'] = DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(item['fecha'])),
              item['nombre'],
              item['pkidcliente'],
              item['tiempoentrega'],
              item['itebis'],
              item['total'] = util.getCurrency(item['total'] ?? 0),
              item['emailcliente'],
              item['cotizacion'],
              item['pkidempresa'],
              item['pkidsuplidorInformar'],
              item['itbisPorc'] == null ? null : checkDouble(item['itbisPorc']),
              item['pkidestatus'],
              item['recibo'],
              item['pkidcompaniaEnvio'],
              item['usuario']);

          dataFactura.add(f);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    listaDataTotal = dataFactura.length;
    return dataFactura;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      dateFrom = DateFormat('yyyy-MM-ddT00:00:00.000').format(DateTime.now());
      dateTo = DateFormat('yyyy-MM-ddT23:59:59.000').format(DateTime.now());
      txtDateFrom.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      txtDateTo.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      numero_factura = "";
    });

    loadData();
  }

  loadData() async {
    listData = getFacturas();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(10),
              horizontal: getProportionateScreenWidth(10)),
          child: DefaultButton(
              text: "Filtrar",
              press: () async {
                await showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Positioned(
                                right: -40,
                                top: -40,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextField(
                                      controller: txtNumber,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: "",
                                          labelText: "Numero Factura",
                                          prefixIcon:
                                              Icon(Icons.post_add_outlined)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextFormField(
                                      controller: txtDateFrom,
                                      keyboardType: TextInputType.none,
                                      showCursor: false,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          hintText: "",
                                          prefixIcon: Icon(
                                            Icons.calendar_today,
                                          ),
                                          labelText: "Fecha Desde"),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await getDatePicker(context);

                                        if (pickedDate != null) {
                                          setState(() {
                                            dateFrom = DateFormat(
                                                    'yyyy-MM-ddT00:00:00.000')
                                                .format(pickedDate);
                                            txtDateFrom.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(pickedDate);
                                          });
                                        } else {
                                          dateFrom = DateFormat(
                                                  'yyyy-MM-ddT00:00:00.000')
                                              .format(DateTime.now());
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextFormField(
                                      controller: txtDateTo,
                                      keyboardType: TextInputType.none,
                                      showCursor: false,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          hintText: "",
                                          prefixIcon: Icon(
                                            Icons.calendar_today,
                                          ),
                                          labelText: "Fecha Hasta"),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await getDatePicker(context);

                                        if (pickedDate != null) {
                                          setState(() {
                                            dateTo = DateFormat(
                                                    'yyyy-MM-ddT23:59:59.999')
                                                .format(pickedDate);
                                            txtDateTo.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(pickedDate);
                                          });
                                        } else {
                                          dateTo = DateFormat(
                                                  'yyyy-MM-ddT23:59:59.999')
                                              .format(DateTime.now());
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenWidth(5),
                                  ),
                                  DefaultButton(
                                      text: "Buscar",
                                      press: () {
                                        FocusScope.of(context).unfocus();

                                        setState(() {
                                          setState(() {
                                            numero_factura = txtNumber.text;
                                            loadData();
                                          });
                                        });

                                        Navigator.of(context).pop();
                                      })
                                ],
                              ),
                            ],
                          ),
                        ));
              })),
      Expanded(
        child: FutureBuilder(
            future: listData,
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return ListView.separated(
                      itemBuilder: (context, index) => const LoadingList(),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
                      itemCount: 8);
                case ConnectionState.done:
                  if (snapshot.data!.length == 0) {
                    return const Center(
                      child: Text('No existe información para mostrar'),
                    );
                  }

                  final posts = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(snapshot.data![index].id.toString()),
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration:
                                const BoxDecoration(color: Colors.blueAccent),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.print,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                          child: Card(
                            margin: const EdgeInsets.all(8.0),
                            elevation: 0.5,
                            child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, FacturaDetalle.routeName,
                                      arguments: FacturaDetalleArguments(
                                          facturaId: snapshot.data![index].id));
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                visualDensity: const VisualDensity(vertical: 1),
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(snapshot.data![index].numeroFactura
                                        .toString())
                                  ],
                                ),
                                title: Text(
                                  snapshot.data![index].nombre.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data![index].fecha),
                                    Text(
                                      snapshot.data![index].usuario.toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                trailing: Text(snapshot.data![index].total,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                                enabled: snapshot.data![index].pkidestatus
                                        .toString() !=
                                    ""),
                          ),
                          onDismissed: (value) {},
                        );
                      });
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            }),
      )
    ]);
  }
}
