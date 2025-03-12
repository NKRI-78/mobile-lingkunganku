import 'package:intl/intl.dart';

class Price {
  Price._();
  static currency(double value) {
    String formattedCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0, // No decimals
    ).format(value);

    return formattedCurrency;
  }
  static currencyForum(double value) {
    String formattedCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'IDR ',
      decimalDigits: 0, // No decimals
    ).format(value);

    return formattedCurrency;
  }
}