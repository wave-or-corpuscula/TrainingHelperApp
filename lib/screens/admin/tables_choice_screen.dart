import 'package:flutter/material.dart';


class TableChoice extends StatelessWidget {
  const TableChoice({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Список моделей'),
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/count_type_records');
                    }, 
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amber),
                      minimumSize: WidgetStatePropertyAll(Size(175, 40)),
                    ),
                    child: const Text('Типы счета'),
                  ),
                  const SizedBox(height: 10,),
                  TextButton(
                    onPressed: () {}, 
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amber),
                      minimumSize: WidgetStatePropertyAll(Size(175, 40)),
                    ),
                    child: const Text('Типы упражнений'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
