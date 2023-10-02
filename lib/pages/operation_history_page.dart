import 'package:flutter/material.dart';
import 'package:nst_test/model/data.dart';
import 'package:intl/intl.dart';
import 'package:nst_test/storage/data_manager.dart';
import 'package:nst_test/pages/home_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  late Future<List<Data>> dataList;

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    dataList = loadDataList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'История операций',
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => const HomePage());
              Navigator.pushReplacement(context, route);
            },
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  final date = DateFormat('dd.MM.yyyy').format(DateTime.now()).toString();
                  final dataListValue = await dataList;
                  saveDataListToFile(dataListValue, date);
                  _showMessage('Файл сохранен в папку "Загрузки"');
                },
                icon: const Icon(Icons.file_download))
          ],
        ),
        body: FutureBuilder<List<Data>>(
            future: dataList,
            builder: (context, snapshot) {
              if (snapshot.data?.isNotEmpty == true ) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Целевая валюта: ${snapshot.data?[index].targetCurrencyCod}'),
                            const SizedBox(height: 4,),
                            Text(
                                'Исходная валюта: ${snapshot.data?[index].sourceCurrencyCod}'),
                            const SizedBox(height: 4,),
                            Text(
                                'Сумма после конвертации в рублях: ${snapshot.data?[index].currencyAmount}'),
                            const SizedBox(height: 4,),
                            Text(
                                'Сумма до конвертации в валюте: ${snapshot.data?[index].sumTotal}'),
                            const SizedBox(height: 4,),
                            Text(
                                'Дата и время конвертации: ${snapshot.data?[index].dateTime}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('Здесь пока пусто'));
              }
            }),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          content: Text(
            message,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),
          ),
        )
    );
  }
}
