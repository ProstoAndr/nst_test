class Converter {
  /// Converts the given value based on the currency amount.

  /// @param text The string representation of the currency amount.
  /// @param value The value to be converted.
  /// @return The converted value.
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

/// Handles the case when the currency amount is less than zero.
///
/// @return The value returned when currency amount is less than zero.
Never valueLessThanZero() {
  throw ArgumentError('Value less than zero');
}

/// Handles the case when the currency amount exceeds the maximum allowed value.
///
/// @return The value returned when currency amount is too large.
Never valueIsTooLarge() {
  throw ArgumentError('The value is too large');
}