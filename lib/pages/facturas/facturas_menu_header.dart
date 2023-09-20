import 'package:flutter/material.dart';

class FacturasMenuHeader {
  getAppBar(title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.lightBlue,
      actions: [
        PopupMenuButton(onSelected: (value) {
          // your logic

          // Navigator.pushNamed(context, value.toString());
        }, itemBuilder: (BuildContext bc) {
          return const [
            PopupMenuItem(
              value: '/about',
              child: Text("Contacto"),
            ),
            PopupMenuItem(
              value: '/contact',
              child: Text("Acerca de"),
            )
          ];
        })
      ],
    );
  }
}
