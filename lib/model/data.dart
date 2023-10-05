class Data {
  /// The currency code of the target currency.
  final String targetCurrencyCod;

  /// The currency code of the source currency.
  final String sourceCurrencyCod;

  /// The total sum after conversion.
  final double sumTotal;

  /// The sum before conversion.
  final double currencyAmount;

  /// The date and time of the conversion.
  final DateTime dateTime;

  /// Constructs a new Data object.

  /// @param targetCurrencyCod The currency code of the target currency.
  /// @param sourceCurrencyCod The currency code of the source currency.
  /// @param sumTotal The total sum after conversion.
  /// @param currencyAmount The sum before conversion.
  /// @param dateTime The date and time of the conversion.
  Data(this.targetCurrencyCod, this.sourceCurrencyCod, this.sumTotal,
      this.currencyAmount, this.dateTime);
}