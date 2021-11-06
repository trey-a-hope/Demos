import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:patreon/demo_page.dart';
import 'package:patreon/person_model.dart';

const String HIVE_BOX_KVP = 'HIVE_BOX_KVP';
const String HIVE_BOX_PEOPLE = 'HIVE_BOX_PEOPLE';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Hive.
  await Hive.initFlutter();

  //Register the person object.
  Hive.registerAdapter(PersonAdapter());

  //Open both boxes for database use.
  await Hive.openBox<dynamic>(HIVE_BOX_KVP);
  await Hive.openBox<dynamic>(HIVE_BOX_PEOPLE);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoPage(),
    );
  }
}
