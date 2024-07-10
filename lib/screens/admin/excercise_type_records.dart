import 'package:flutter/material.dart';
import 'package:training_helper_app/models/base_model.dart';

import 'package:training_helper_app/models/excercise_type.dart';

import 'package:training_helper_app/screens/admin/excercise_type_details.dart';


class ExcerciseTypeRecords extends StatefulWidget {
  const ExcerciseTypeRecords({super.key});

  @override
  State<ExcerciseTypeRecords> createState() => _ExcerciseTypeRecordsState();
}

class _ExcerciseTypeRecordsState extends State<ExcerciseTypeRecords> {
  List<ExcerciseType> recordsList = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (recordsList.isEmpty) {
      updateListView();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 174),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetails('Новая запись'); // TODO: Localization
        },
        tooltip: 'Добавить запись', // TODO: Localization
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Типы упражнений'), // TODO: Localization
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

  ListView getListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(recordsList[position].name),
            subtitle: const Text('Нажмите чтобы изменить'), // TODO: Localization
            onTap: () {
              navigateToDetails('Изменить запись', record: recordsList[position]); // TODO: Localization
            }
          ),
        );
      }
    );
  }

  void updateListView() {
    Future<List<BaseModel>> futureList = ExcerciseType.query().getList();
    futureList.then((baseModelList) {
      setState(() {
        recordsList = baseModelList.cast<ExcerciseType>();
        count = recordsList.length;
      });
    });
  }

  void navigateToDetails(String title, {ExcerciseType? record}) async {
    bool updateRequired = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ExcerciseTypeDetails(title, record: record);
    }));

    if (updateRequired) {
      updateListView();
    }
  }

  void navigateBack({bool updateRequired = false}) {
    Navigator.pop(context, false);
  }
}