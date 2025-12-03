import 'package:intl/intl.dart';

/// Format integer amounts to Indonesian locale strings.
/// Examples:
///   20000 -> "20.000"
///   toIdr(withSymbol: true) -> "Rp 20.000"

String formatIdrPlain(int? value) {
  if (value == null) return '-';
  return NumberFormat.decimalPattern('id_ID').format(value);
}

String formatIdrCurrency(int? value, {bool withSymbol = true}) {
  if (value == null) return '-';
  if (withSymbol) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(value);
  }
  return NumberFormat.decimalPattern('id_ID').format(value);
}

extension IdNumberExtension on int? {
  String toIdr({bool withSymbol = true}) =>
      formatIdrCurrency(this, withSymbol: withSymbol);
}
