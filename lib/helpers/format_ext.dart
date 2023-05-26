import 'package:intl/intl.dart';

String formatCurrency(int amount) {
  NumberFormat currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
  return currencyFormat.format(amount);
}