import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mi_app_01/models/facturasM.dart';
import 'package:mi_app_01/utils/size_config.dart';
import 'package:mi_app_01/utils/constants.dart';
import '../../components/default_button.dart';
import '../../presentation/screens/api/restfull.dart';
import '../../utils/utils.dart';
import 'facturaDetalle.dart';
import '../../presentation/screens/menu/menu_header.dart';

int listaDataCount = 0;
String dateFrom = DateFormat('yyyy-MM-ddT00:00:00.000').format(DateTime.now());
String dateTo = DateFormat('yyyy-MM-ddT23:59:59.999').format(DateTime.now());
List<Facturas> dataFactura = [];
Future<List<Facturas>>? listData;
Future<List<Facturas>>? listaData;

class FacturasListado extends StatefulWidget {
  static String routeName = "/facturaListado";
  const FacturasListado({super.key});

  @override
  State<FacturasListado> createState() => _FacturasListadoState();
}

class _FacturasListadoState extends State<FacturasListado> {
  loadData() async {
    listData = getFacturas();
  }

  Future<List<Facturas>> getFacturas() async {
    List<Facturas> dataFactura = [];

    String url = "${Environment.apiUrl}/Facturas?pkidEmpresa=1&isCliente=0";

    var body = {
      "numero_factura": "",
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
              item['total'] = getCurrency(item['total'] ?? 0),
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
        print(e);
      }
    }

    return dataFactura;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MenuHeader().getAppBar('Facturas'),
      body: SafeArea(
        child: Column(
          children: [
            FacturasHeader(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: listData,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Facturas>> snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(snapshot.data![index].id.toString()),
                              background: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: const BoxDecoration(
                                    color: Colors.blueAccent),
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
                                margin: EdgeInsets.all(8.0),
                                elevation: 0.5,
                                child: ListTile(
                                    onTap: () {
                                      print('click');
                                      print(snapshot.data![index].id);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Details(
                                                facturaId:
                                                    snapshot.data![index].id),
                                          ));
                                      /*    Navigator.pushNamed(
                                          context, 'facturaDetalle',
                                          arguments: 48);*/
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    visualDensity:
                                        const VisualDensity(vertical: 1),
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data![index].numeroFactura
                                            .toString())
                                      ],
                                    ),
                                    title: Text(
                                      snapshot.data![index].nombre.toString(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data![index].fecha),
                                        Text(
                                          snapshot.data![index].usuario
                                              .toString(),
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
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class FacturasHeader extends StatefulWidget {
  const FacturasHeader({
    super.key,
  });

  @override
  State<FacturasHeader> createState() => _FacturasHeaderState();
}

class _FacturasHeaderState extends State<FacturasHeader> {
  showModalSearch() {}

  @override
  Widget build(BuildContext context) {
    TextEditingController txtNumber = TextEditingController();
    TextEditingController txtDateFrom = TextEditingController();
    TextEditingController txtDateTo = TextEditingController();

    String dateFromFilter = "";
    String dateToFilter = "";

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(10),
              horizontal: getProportionateScreenWidth(10)),
          child: TextField(
              decoration: InputDecoration(
            labelText: 'Buscar',
            suffixIcon: IconButton(
              onPressed: () async {
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
                                            dateFromFilter = DateFormat(
                                                    'yyyy-MM-ddT00:00:00.000')
                                                .format(pickedDate);
                                            txtDateFrom.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(pickedDate);
                                          });
                                        } else {
                                          print("Date is not selected");
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
                                            dateToFilter = DateFormat(
                                                    'yyyy-MM-ddT23:59:59.999')
                                                .format(pickedDate);
                                            txtDateTo.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(pickedDate);
                                          });
                                        } else {
                                          print("Date is not selected");
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
                                        _FacturasListadoState fl =
                                            _FacturasListadoState();

                                        setState(() {
                                          dateFrom = dateFromFilter;
                                          dateTo = dateToFilter;
                                          dataFactura = [];
                                          fl.loadData();
                                        });

                                        Navigator.of(context).pop();
                                      })
                                ],
                              ),
                            ],
                          ),
                        ));
              },
              icon: Icon(Icons.search),
            ),
            hintText: 'Buscar',
            fillColor: const Color.fromARGB(31, 240, 234, 234),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(color: kTextColor),
                gapPadding: 1),
          )),
        ),
      ],
    );
  }
}
