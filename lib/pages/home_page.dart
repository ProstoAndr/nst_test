import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nst_test/api/currency_api.dart';
import 'package:nst_test/convert/converter.dart';
import 'package:nst_test/model/data.dart';
import 'package:nst_test/pages/operation_history_page.dart';
import 'package:nst_test/pages/project_page.dart';
import 'package:nst_test/storage/data_manager.dart';

class HomePage extends StatefulWidget {
  /// Constructs a new instance of HomePage.
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late Future<CurrencyList> currencyList;
  final converter = Converter();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final _dataController = TextEditingController();

  double? sum ;

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currencyList = getCurrencyList();
  }

  Future<void> _pullRefresh() async {
    final freshCurrencyList = getCurrencyList();
    setState(() {
      currencyList = freshCurrencyList;
    });
  }

  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            DateFormat('dd.MM.yyyy').format(
                DateTime(now.year, now.month, now.day - 1)).toString(),
          ),
          actions: <Widget>[
            PopupMenuButton(
              icon: const Icon(Icons.menu),
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  child: TextButton(
                    child: const Text('О приложении'),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => const ProjectPage());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: TextButton(
                    child: const Text('История операций'),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => const HistoryPage());
                      Navigator.push(context, route);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: FutureBuilder<CurrencyList>(
            future: currencyList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.currency.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _showDialog(snapshot.data!.currency[index].charCode,
                            snapshot.data!.currency[index].vunitRate);
                      },
                      child: Card(
                        child: ListTile(
                          title: Text('${snapshot.data?.currency[index].name}'),
                          subtitle: Text(
                              '${snapshot.data?.currency[index].vunitRate}'),
                          leading: Text(
                              '${snapshot.data?.currency[index].charCode}'),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    _showMessage(snapshot.error?.toString() ?? ''));
                return ListView(
                  padding: const EdgeInsets.all(32),
                  children: const [],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  void _showDialog(String charCode, String vunitRate) {
    final formattedVunitRate = vunitRate.replaceAll(',', '.');

    final vunitRateD = double.parse(formattedVunitRate);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: const Text('Конвертация валюты'),
              content: Form(
                key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(charCode),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Введите сумму',
                          icon: Icon(Icons.money),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 30,
                        controller: _dataController,
                        validator: _validateField,
                      ),
                      const Text('RUB'),
                      const SizedBox(height: 5),
                      Text(sum?.toString() ?? ""),
                    ]),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final value = converter.convert(_dataController.text,vunitRateD);
                      setState(() {
                        sum = value;
                      });
                      final data = Data(
                          'RUB',
                          charCode,
                          double.parse(_dataController.text),
                          value,
                          DateTime.now()
                      );
                      saveData(data);
                    }
                  },
                  child: const Text('Конвертировать'),
                ),
              ],
            ),
        );
      },
    );
  }

  String? _validateField(String? value) {
    final fieldExp = RegExp(r'^[0-9]+');
    if (value == null || value.isEmpty) {
      return 'Введите данные.';
    } else if (!fieldExp.hasMatch(value)) {
      return 'Введите только числа.';
    } else {
      return null;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
          content: Text(
            message,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),
          ),
        )
    );
  }
}