import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

class Util {
  String getCurrency(double value, [bool symbol = true]) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
            symbol: (symbol == true ? 'RD\$' : ''),
            thousandSeparator: ',',
            decimalSeparator: '.',
            symbolAndNumberSeparator: '',
            fractionDigits: 2,
            compactFormatType: CompactFormatType.long));

    return fmf.output.symbolOnLeft;
  }

  formatDate(now) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);

    return formattedDate;
  }
}

Future<String?> showDialog1(
    BuildContext context, String title, String description) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Aceptar'),
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );
}
