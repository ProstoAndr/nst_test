import 'dart:io';

import 'package:nst_test/model/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;
import 'package:path_provider/path_provider.dart';

/// The key used to store and retrieve the data list in SharedPreferences.
const kDataListKey = 'dataList';

/// Loads the data list from SharedPreferences.

/// @return A Future representing the list of Data objects.
Future<List<Data>> loadDataList() async {
  final prefs = await SharedPreferences.getInstance();
  final dataIds = prefs.getStringList(kDataListKey);

  if (dataIds != null) {
    final dataList = dataIds.map((id) {
      final targetCurrencyCod = prefs.getString('$id-targetCurrencyCod') ?? '';
      final sourceCurrencyCod = prefs.getString('$id-sourceCurrencyCod') ?? '';
      final sumTotal = prefs.getDouble('$id-sumTotal') ?? 0.0;
      final currencyAmount = prefs.getDouble('$id-currencyAmount') ?? 0.0;
      final dateTime = DateTime.tryParse(prefs.getString('$id-dateTime') ?? '');

      return Data(
        targetCurrencyCod,
        sourceCurrencyCod,
        sumTotal,
        currencyAmount,
        dateTime!
      );
    }).toList();
    return dataList;
  } else {
    return [];
  }
}

/// Saves the given Data object to SharedPreferences.

/// @param newData The Data object to be saved.
Future saveData(Data newData) async {
  final prefs = await SharedPreferences.getInstance();

  final dataIds = prefs.getStringList(kDataListKey) ?? [];
  final newId = dataIds.length + 1;

  await prefs.setString('$newId-targetCurrencyCod', newData.targetCurrencyCod);
  await prefs.setString('$newId-sourceCurrencyCod', newData.sourceCurrencyCod);
  await prefs.setDouble('$newId-sumTotal', newData.sumTotal);
  await prefs.setDouble('$newId-currencyAmount', newData.currencyAmount);
  await prefs.setString('$newId-dateTime', newData.dateTime.toString());

  dataIds.add(newId.toString());
  await prefs.setStringList(kDataListKey, dataIds);
}

/// Saves the given list of Data objects to a file in XML format.

/// @param dataList The list of Data objects to be saved.
/// @param date The date for the file name.
Future saveDataListToFile(List dataList, String date) async {
  final xmlBuilder = xml.XmlBuilder();

  final fileName = 'История ковертации валюты за $date.xml';

  xmlBuilder.element('DataList', nest: () {
    for (final data in dataList) {
      xmlBuilder.element('Data', nest: () {
        xmlBuilder.element('targetCurrencyCod', nest: data.targetCurrencyCod);
        xmlBuilder.element('sourceCurrencyCod', nest: data.sourceCurrencyCod);
        xmlBuilder.element('sumTotal', nest: data.sumTotal.toString());
        xmlBuilder.element('currencyAmount',
            nest: data.currencyAmount.toString());
        xmlBuilder.element('dateTime', nest: data.dateTime.toString());
      });
    }
  });

  final xmlString = xmlBuilder.buildDocument().toXmlString(pretty: true);

  final path = await getDownloadsDirectory();

  final filePath = '$path/$fileName';

  final file = File(filePath);

  await file.writeAsString(xmlString);
}
