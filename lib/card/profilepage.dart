import 'package:flutter/material.dart';
import 'package:mi_app_01/card/profile_container.dart';
import 'package:mi_app_01/models/facturasDetalleModel.dart';

class ProfilePage extends StatelessWidget {
  final String text;

  const ProfilePage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0.0),
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 1.0, offset: Offset(0, 1))
                ],
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white,
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  padding: const EdgeInsets.all(9),
                  decoration: const BoxDecoration(
                      color: Color(0xff8d7bef), shape: BoxShape.circle),
                  child: const Icon(Icons.my_location, color: Colors.white),
                ),
                title: const Text("Enviar A"),
                subtitle: Text(text),
                trailing: IconButton(
                    icon: const Icon(Icons.location_city), onPressed: () {}),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
