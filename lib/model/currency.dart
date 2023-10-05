import 'package:xml/xml.dart';

class Currency {
  /// The currency code.
  final String charCode;

  /// The name of the currency.
  final String name;

  /// The conversion rate of the currency
  final String vunitRate;

  /// Constructs a new Currency.

  /// @param charCode The currency code.
  /// @param name The name of the currency.
  /// @param vunitRate The conversion rate of the currency.
  Currency(this.charCode, this.name, this.vunitRate);

  /// Constructs a Currency from an XML element.

  /// @param xml The XML element representing the currency.
  factory Currency.fromXml(XmlElement xml) {
    return Currency(
      xml.findAllElements("CharCode").single.innerText,
      xml.findAllElements("Name").single.innerText,
      xml.findAllElements("VunitRate").single.innerText,
    );
  }
}
