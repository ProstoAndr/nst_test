class Converter {
  double convert(String text, double value) {
    final currencyAmount = double.parse(text);

    final max = BigInt.parse('100000000000000000000000000000');
    if (currencyAmount < 0) {
      return valueLessThanZero();
    } else if (BigInt.parse(text) > max) {
      return valueIsTooLarge();
    } else {
      return currencyAmount * value;
    }
  }
}

Never valueLessThanZero() {
  throw ArgumentError('Value less than zero');
}

Never valueIsTooLarge() {
  throw ArgumentError('The value is too large');
}