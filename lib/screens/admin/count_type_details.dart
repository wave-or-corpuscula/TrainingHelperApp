import 'package:flutter/material.dart';

import 'package:training_helper_app/models/count_type.dart';


class CountTypeDetails extends StatefulWidget {

  final String _title;
  final CountType? countTypeRecord;

  const CountTypeDetails(this._title, {super.key, this.countTypeRecord});

  @override
  State<CountTypeDetails> createState() => _CountTypeDetailsState();
}

class _CountTypeDetailsState extends State<CountTypeDetails> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if (widget.countTypeRecord != null) {
      nameController.text = widget.countTypeRecord!.name;
    }
      
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
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Название типа счета',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
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
                        _showSnackBar(context, 'Запись удалена');
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
      ),
    );
  }

  void _save() async {

    navigateBack(updateRequired: true);

    CountType? newRecord;
    if (widget.countTypeRecord == null) {
      newRecord = CountType(nameController.text);
      await newRecord.insert(); // TODO: Catch possible exceptions
      if (!mounted) return;
      _showSnackBar(context, 'Запись создана');
    }
    else {
      widget.countTypeRecord?.name = nameController.text;
      await widget.countTypeRecord!.update(); // TODO: Catch possible exceptions
      if (!mounted) return;
      _showSnackBar(context, 'Запись изменена');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar, 
      snackBarAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 250),
    ));
  }

  void navigateBack({bool updateRequired = false}) {
    Navigator.pop(context, updateRequired);
  }  

  Future<void> _delete() async {

    if (widget.countTypeRecord != null) {
      await widget.countTypeRecord!.delete().then((_) {
        navigateBack(updateRequired: true);
      });
      // TODO: Catch possible exceptions
    }
  }
}