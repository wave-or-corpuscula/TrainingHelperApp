import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:training_helper_app/models/count_type.dart';

import 'package:training_helper_app/screens/admin/count_type_details.dart';


class CountTypeRecords extends StatefulWidget {
  const CountTypeRecords({super.key});

  @override
  State<CountTypeRecords> createState() => _CountTypeRecordsState();
}

class _CountTypeRecordsState extends State<CountTypeRecords> {

  List<CountType> cTypeList = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (cTypeList.isEmpty) {
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
        title: const Text('Count type model'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              navigateBack();
            },
          ),
      ),
      body: SafeArea(
        child: getCountTypeListView(),
      ),
    );
  }

  ListView getCountTypeListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child:  ListTile(
            title: Text(cTypeList[position].name),
            subtitle: const Text('Tap to change'),
            onTap: () {
              navigateToDetails('Изменить запись', record: cTypeList[position]);
            }
          ),
        );
      }
    );
  }

  void updateListView() {
    setState(() {
      Future<List<CountType>> cTypeFutureList = CountType.getList();
      cTypeFutureList.then((cTypeListUpdated) {
        setState(() {
          cTypeList = cTypeListUpdated;
          count = cTypeListUpdated.length;
        });
      });
    });
  }

  void navigateToDetails(String title, {CountType? record}) async {
    bool updateRequired = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CountTypeDetails(title, countTypeRecord: record,);
    }));
    log('Navigated back with updateRequired: $updateRequired');

    if (updateRequired) {
      updateListView();
      log('State updated');
    }
  }

  void navigateBack({bool updateRequired = false}) {
    Navigator.pop(context, false);
  }
}