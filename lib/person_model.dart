import 'package:hive/hive.dart';
part 'person_model.g.dart';

@HiveType(typeId: 0) //(between 0 and 223)
class Person extends HiveObject {
  Person({required this.name, required this.age, required this.gender});

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  String gender;
}
