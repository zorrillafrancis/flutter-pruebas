import 'package:flutter/material.dart';

class MenuHeader {
  getAppBar(title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.lightBlue,
      actions: [
        PopupMenuButton(onSelected: (value) {
          // your logic

          // Navigator.pushNamed(context, value.toString());
        }, itemBuilder: (BuildContext bc) {
          return const [
            PopupMenuItem(
              value: '/hello',
              child: Text("Hello"),
            ),
            PopupMenuItem(
              value: '/about',
              child: Text("About"),
            ),
            PopupMenuItem(
              value: '/contact',
              child: Text("Contact"),
            )
          ];
        })
      ],
    );
  }
}
