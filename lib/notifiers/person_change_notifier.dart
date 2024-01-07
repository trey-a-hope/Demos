import 'dart:collection';

import 'package:demos/models/person.dart';
import 'package:flutter/material.dart';

class PersonChangeNotifier extends ChangeNotifier {
  final List<Person> _people = [];

  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void add(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void update(Person updatedPerson) {
    // Searches the list from index [start] to the end of the list.
    // The first time an object o is encountered so that o == element,
    // the index of o is returned.
    final index = _people.indexOf(updatedPerson);
    final oldPerson = _people[index];

    // If found person's name/age is
    // different from the one the UI is giving us...
    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      // Update person at that index with new age and name.
      _people[index] = oldPerson.update(
        updatedPerson.name,
        updatedPerson.age,
      );

      notifyListeners();
    }
  }
}
