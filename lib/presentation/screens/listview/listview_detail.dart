import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/menu/menu_bottom.dart';
import 'package:mi_app_01/presentation/screens/menu/menu_header.dart';

class Details extends StatefulWidget {
  final String numeroFactura;

  const Details({super.key, required this.numeroFactura});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print(widget.numeroFactura);
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtFactura = TextEditingController();
    TextEditingController txtFecha = TextEditingController();
    TextEditingController txtCliente = TextEditingController();

    return Scaffold(
        appBar: MenuHeader().getAppBar('Detalle de la Factura'),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              getTextForm(txtFactura, 'No. Factura',
                  const Icon(Icons.payment_outlined)),
              const SizedBox(height: 5),
              getTextForm(txtFecha, 'Fecha', const Icon(Icons.date_range)),
              const SizedBox(height: 5),
              getTextForm(txtCliente, 'Cliente', const Icon(Icons.person)),
              const SizedBox(height: 5),
              getTextForm(txtCliente, 'Ciudad', const Icon(Icons.person)),
              const SizedBox(height: 5),
              getTextForm(txtCliente, 'Nombre', const Icon(Icons.person)),
              const SizedBox(height: 5),
              getTextForm(txtCliente, 'Teléfono', const Icon(Icons.person)),
              const SizedBox(height: 5),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue[500],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.business),
              label: 'Facturas',
              backgroundColor: Colors.blue[500],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school),
              label: 'School',
              backgroundColor: Colors.blue[500],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'Configuración',
              backgroundColor: Colors.blue[500],
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: onItemTapped,
        ));
  }
}

getText(TextEditingController ctrl, String labelText, Icon suffixIcon) {
  return TextField(
    enabled: false,
    controller: ctrl,
    decoration: InputDecoration(
        labelText: labelText.toString(),
        suffixIcon: suffixIcon,
        fillColor: const Color.fromARGB(31, 219, 9, 9),
        border: const OutlineInputBorder(),
        filled: false),
    onChanged: (text) {},
  );
}

getTextForm(TextEditingController ctrl, String labelText, Icon suffixIcon) {
  return TextFormField(
    enabled: false,
    controller: ctrl,
    decoration: InputDecoration(
        labelText: labelText.toString(),
        suffixIcon: suffixIcon,
        isDense: true,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black))),

    // controller: cpfcontroller,
  );
}
