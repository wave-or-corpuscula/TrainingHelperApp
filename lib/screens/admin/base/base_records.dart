import 'package:flutter/material.dart';

abstract class BaseRecords<T> extends StatefulWidget {
  const BaseRecords({super.key});
}


abstract class BaseRecordsState<T, W extends BaseRecords<T>> extends State<W> {
  List<T> recordsList = [];
  int count = 0;

  String get title;

  Widget buildListTile(T record);

  @override
  Widget build(BuildContext context) {

    if (recordsList.isEmpty) {
      updateListView();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 174),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetails('Новая запись');
        },
        tooltip: 'Добавить запись',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Типы счета'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              navigateBack();
            },
          ),
      ),
      body: SafeArea(
        child: getListView(),
      ),
    );

  }


  ListView getListView();

  void navigateBack({bool updateRequired = false}) {
    Navigator.pop(context, false);
  }

  Future<void> updateListView() async {
    final updatedList = await getList();
    setState(() {
      recordsList = updatedList;
      count = updatedList.length;
    });
  }

  Future<List<T>> getList();

  void navigateToDetails(String title, {T? record});

}