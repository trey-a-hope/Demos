part of '../person_page.dart';

/* 
  You can use the @immutable metatag from the meta
  package to get helpful analyzer warnings on classes 
  you intend to be immutable:

  The metatag does not make your class immutable (if only
  it were that easy), but in this example, you will get
  a warning stating that one or more of your fields
  are not final. If you try to add the const keyword
  to your constructor while there are mutable properties,
  you'll get an error that tells you essentially the
  same thing. If a class has the @immutable tag on it,
  any subclasses that aren't immutable will also have warnings.
*/

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person update([String? name, int? age]) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      uuid: uuid,
    );
  }

  String get displayName => '$name ($age years old)';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() => 'Person(name: $name, age: $age, uuid: $uuid)';
}
