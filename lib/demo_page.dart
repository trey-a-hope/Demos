import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:patreon/main.dart';
import 'package:patreon/person_model.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  TextEditingController _keyController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  late Box<dynamic> _keyValueBox;
  late Box<dynamic> _peopleBox;

  @override
  void initState() {
    super.initState();
    _keyValueBox = Hive.box<dynamic>(HIVE_BOX_KVP);
    _peopleBox = Hive.box<dynamic>(HIVE_BOX_PEOPLE);
  }

  //Saves the [key] - [value] pair.
  Future<void> _put({required String key, required dynamic value}) async {
    return _keyValueBox.put(key, value);
  }

  //Saves the value with an auto-increment key.
  Future<int> _add({required dynamic value}) async {
    return _peopleBox.add(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive 2.0.4'),
      ),
      body: SafeArea(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Key/Value Pair',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _keyController,
                      decoration: InputDecoration(hintText: 'Key'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _valueController,
                      decoration: InputDecoration(hintText: 'Value'),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                  ),
                  onPressed: () {
                    if (_keyController.text != '' &&
                        _valueController.text != '') {
                      _put(
                        key: _keyController.text,
                        value: _valueController.text,
                      );
                    }
                  },
                  child: Icon(Icons.save),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: _keyValueBox.listenable(),
              builder: (context, box, widget) {
                box as Box;

                if (box.isNotEmpty) {
                  Map map = box.toMap();
                  return DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Key',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Value',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                    ],
                    rows: <DataRow>[
                      for (var entry in map.entries) ...[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('${entry.key}')),
                            DataCell(Text('${entry.value}')),
                            DataCell(
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  box.delete(entry.key);
                                },
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            Divider(color: Colors.black),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'People',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: 'Name'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _ageController,
                      decoration: InputDecoration(hintText: 'Age'),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                  ),
                  onPressed: () {
                    if (_nameController.text != null &&
                        _ageController.text != null) {
                      _add(
                        value: Person(
                          name: _nameController.text,
                          age: int.parse(_ageController.text),
                        ),
                      );
                    }
                  },
                  child: Icon(Icons.save),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: _peopleBox.listenable(),
              builder: (context, box, widget) {
                box as Box;

                if (box.isNotEmpty) {
                  Map map = box.toMap();
                  return DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Key',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Person',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                    ],
                    rows: <DataRow>[
                      for (var entry in map.entries) ...[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('${entry.key}')),
                            DataCell(
                              Text('${entry.value.name}, ${entry.value.age}'),
                            ),
                            DataCell(
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  box.delete(entry.key);
                                },
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _keyValueBox.clear();
                    _keyController.clear();
                    _valueController.clear();
                  },
                  child: Text('Clear Key Value'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _peopleBox.clear();
                    _nameController.clear();
                    _ageController.clear();
                  },
                  child: Text('Clear People'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
