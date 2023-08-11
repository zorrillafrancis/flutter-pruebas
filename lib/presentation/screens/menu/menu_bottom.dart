import 'package:flutter/material.dart';

class MenuBottom extends StatefulWidget {
  const MenuBottom({super.key});

  @override
  State<MenuBottom> createState() => MenuBottomState();
}

class MenuBottomState extends State<MenuBottom> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.blue[500],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.business),
          label: 'Business',
          backgroundColor: Colors.blue[500],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.school),
          label: 'School',
          backgroundColor: Colors.blue[500],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Colors.blue[500],
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      onTap: onItemTapped,
    );
  }
}
