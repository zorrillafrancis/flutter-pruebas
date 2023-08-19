import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

class Util {
  String getCurrency(double value) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
            symbol: 'RD\$',
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


