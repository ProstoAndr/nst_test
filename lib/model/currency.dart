import 'package:xml/xml.dart';

class Currency {
  final String charCode;
  final String name;
  final String vunitRate;

  Currency(this.charCode, this.name, this.vunitRate);

  factory Currency.fromXml(XmlElement xml) {
    return Currency(
      xml.findAllElements("CharCode").single.innerText,
      xml.findAllElements("Name").single.innerText,
      xml.findAllElements("VunitRate").single.innerText,
    );
  }
}
