import 'dart:collection';

import 'package:flutter/material.dart';

import '../../utils/message.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> menssageList = [
    Message(text: "hola", fromWho: FromWho.mine),
    Message(text: "ya regrese", fromWho: FromWho.mine)
  ];

  Future<void> sendMessage(String text) async {}
}

class CartModel extends ChangeNotifier {
  final List<Items> _items = [];

  UnmodifiableListView<Items> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.length * 42;

  void add(Items item) {
    _items.add(item);
    notifyListeners();
  }
}

class TotalsProvider with ChangeNotifier {
  final double total;
  final double subtotal;
  final double? itbis;
  final double? descuento;

  TotalsProvider(
      {required this.total,
      required this.subtotal,
      this.itbis,
      this.descuento});

  void add(double total, double subtotal, double? itbis, double? descuento) {
    total = total;
    subtotal = subtotal;
    itbis = itbis;
    descuento = descuento;

    notifyListeners();
  }
}
