import 'package:flutter/material.dart';
import 'package:nst_test/pages/home_page.dart';

class ProjectPage extends StatelessWidget {
  /// Constructs a new instance of ProjectPage.
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('О приложении'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => const HomePage());
                Navigator.pushReplacement(context, route);
              },
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(top: 32, left: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Информация о разработчике',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ФИО: Петухов Андрей Алексеевич',
                        style: TextStyle(fontSize: 16,)
                    ),
                    SizedBox(height: 16),
                    Text('Начинающий Flutter developer',
                        style: TextStyle(fontSize: 16,)
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Center(
                  child: Text(
                    'Библиотеки, которые использовал',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('xml - для работы с xml файлами',
                        style: TextStyle(fontSize: 16,)),
                    SizedBox(height: 16),
                    Text('http - для работы с http запросами',
                        style: TextStyle(fontSize: 16,)
                    ),
                    SizedBox(height: 16),
                    Text('intl - для форматировании даты',
                        style: TextStyle(fontSize: 16,)
                    ),
                    SizedBox(height: 16),
                    Text(
                        'shared_preferences - для хранении в памяти устройства',
                        style: TextStyle(fontSize: 16,)
                    ),
                    SizedBox(height: 16),
                    Text(
                        'path_provider - для сохранения файла на устройство',
                        style: TextStyle(fontSize: 16,)
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
