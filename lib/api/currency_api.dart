import 'package:nst_test/model/currency.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;



class CurrencyList {
  List<Currency> currency;

  CurrencyList({required this.currency});

  factory CurrencyList.fromXml(String string) {
    final document = XmlDocument.parse(string);
    final currencyXml = document.findAllElements('Valute');
    List<Currency> currencyList = currencyXml.map(Currency.fromXml).toList();

    return CurrencyList(currency: currencyList);
  }
}

Future<CurrencyList> getCurrencyList() async {
  const url = 'http://www.cbr.ru/scripts/XML_daily.asp';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return CurrencyList.fromXml(convertStringToModifiedIntArray(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

String convertStringToModifiedIntArray(String input) {
  List<int> charCodes = input.runes.toList();

  for (int i = 0; i < charCodes.length; i++) {
    if (charCodes[i] >= 192 && charCodes[i] <= 256) {
      charCodes[i] += 848;
    }
  }

  String modifiedString = String.fromCharCodes(charCodes);
  return modifiedString;
}