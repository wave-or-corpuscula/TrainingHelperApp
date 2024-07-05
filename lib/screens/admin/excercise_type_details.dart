import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:training_helper_app/models/count_type.dart';
import 'package:training_helper_app/models/excercise_type.dart';


class ExcerciseTypeDetails extends StatefulWidget {

  final String _title;
  final ExcerciseType? record; 

  const ExcerciseTypeDetails(this._title, {super.key, this.record});

  @override
  State<ExcerciseTypeDetails> createState() => _ExcerciseTypeDetailsState();
}

class _ExcerciseTypeDetailsState extends State<ExcerciseTypeDetails> {

  TextEditingController nameController = TextEditingController();
  TextEditingController postfixController = TextEditingController();

  List<CountType> countTypeList = [];
  CountType? selectedCountType;


  @override
  void initState() {
    super.initState();
    loadCountTypes().then((_) {
      if (widget.record != null) {
        nameController.text = widget.record!.name;
        postfixController.text = widget.record!.postfix;
        selectedCountType = countTypeList.firstWhere((record) => record.id == widget.record!.countTypeId);
      }
    });
  }

  Future<void> loadCountTypes() async {
    var mapList = await CountType.getList();
    setState(() {
      countTypeList = mapList;
      if (mapList.isNotEmpty) {
        selectedCountType = countTypeList.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            navigateBack();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Название упражнения',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: postfixController,
                decoration: InputDecoration(
                  labelText: 'Постфикс упражнения',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownMenu<CountType>(
                    enableSearch: false,
                    enableFilter: false,
                    label: const Text('Выбор типа учета'),
                    initialSelection: selectedCountType,
                    width: 200,
                    onSelected: (CountType? selectedValue) {
                      setState(() {
                        selectedCountType = selectedValue;
                      });
                    },
                    dropdownMenuEntries: countTypeList.map((CountType record) {
                      return DropdownMenuEntry<CountType>(
                        value: record,
                        label: record.name,
                        // child: Text(record.name),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.amber),
                      ),
                      onPressed: () {
                        _save();
                      },
                      child: const Text(
                        'Сохранить'
                      ),
                    ),
                  ),
        
                  const SizedBox(width: 20,),
        
                  Expanded(
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.amber),
                      ),
                      onPressed: () {
                        _delete();
                      }, 
                      child: const Text(
                        'Удалить'
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      )
    );
  }

  void navigateBack({bool updateRequired = false}) {
    Navigator.pop(context, updateRequired);
  }

  Future<void> _save() async {

    String? messageText;
    ExcerciseType newRecord = ExcerciseType(nameController.text, postfixController.text, selectedCountType!.id!);
    if (widget.record == null) {
      await ExcerciseType.insert(newRecord); // TODO: Catch possible exceptions
      messageText = 'Запись создана';
    } else {
      newRecord.id = widget.record!.id;
      await ExcerciseType.update(newRecord); // TODO: Catch possible exceptions      
      messageText = 'Запись изменена';
    }
    navigateBack(updateRequired: true);
    if (!mounted) return;
    _showSnackBar(context, messageText);
  }
  
  void _delete() async {
    
    String messageText;
    navigateBack(updateRequired: true);
    if (widget.record != null) {
      await ExcerciseType.delete(widget.record!);
      messageText = 'Запись удалена';
    } else {
      messageText = 'Запись не удалена';
    }

    _showSnackBar(context, messageText);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar, 
      snackBarAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 250),
    ));
  }
}
