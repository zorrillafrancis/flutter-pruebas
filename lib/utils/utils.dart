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

double checkDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else if (value is int) {
    return 0.0 + value;
  } else {
    return value;
  }
}

Future<DateTime?> getDatePicker(BuildContext context) {
  return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
          2000), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101));
}
