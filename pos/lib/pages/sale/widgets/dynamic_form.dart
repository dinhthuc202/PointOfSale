import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/pages/sale/widgets/form_item.dart';

import '../../../models/so.dart';

class MultiContactFormWidget extends StatefulWidget {
  const MultiContactFormWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MultiContactFormWidgetState();
  }
}

class _MultiContactFormWidgetState extends State<MultiContactFormWidget> {
  List<FromItem> fromItems = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Multi Contacts"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            onSave();
          },
          child: const Text("Save"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          onAdd();
        },
      ),
      body: fromItems.isNotEmpty
          ? ListView.builder(
          itemCount: fromItems.length,
          itemBuilder: (_, index) {
            return fromItems[index];
          })
          : const Center(child: Text("Tap on + to Add Contact")),
    );
  }

  onSave() {
    bool allValid = true;

    for (var element in fromItems) {
      allValid = (allValid && element.isValidated());
    }

    if (allValid) {
      List<String> names =
      fromItems.map((e) => e.contactModel.name!).toList();
      debugPrint("$names");
    } else {
      debugPrint("Form is Not Valid");
    }
  }

  //Delete specific form
  onRemove(ContactModel contact) {
    setState(() {
      int index = fromItems
          .indexWhere((element) => element.contactModel.id == contact.id);

      if (fromItems != null) fromItems.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      ContactModel contactModel = ContactModel(id: fromItems.length);
      fromItems.add(FromItem(
        index: fromItems.length,
        contactModel: contactModel,
        onRemove: () => onRemove(contactModel),
      ));
    });
  }
}
