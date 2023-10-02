class Data {
  final String targetCurrencyCod; //рубли целева
  final String sourceCurrencyCod; //выбранная валюта исходная
  final double sumTotal; //сумма после конвертации
  final double currencyAmount; // сумма до конвертации
  final DateTime dateTime;

  Data(this.targetCurrencyCod, this.sourceCurrencyCod, this.sumTotal,
      this.currencyAmount, this.dateTime);
}