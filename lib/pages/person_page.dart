import 'package:demos/models/person.dart';
import 'package:demos/providers/person_change_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(BuildContext context,
    [Person? person]) {
  var name = person?.name ?? '';
  var age = person?.age ?? 0;

  return showDialog<Person>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('${person == null ? 'Create' : 'Update'} Person}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController..text = name,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (val) => name = val,
            ),
            TextField(
              controller: ageController..text = age.toString(),
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
              onChanged: (val) => age = int.tryParse(val) ?? 0,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (person == null) {
                Navigator.of(context).pop(
                  Person(name: name, age: age),
                );
              } else {
                final updatePerson = person.update(name, age);
                Navigator.of(context).pop(updatePerson);
              }
            },
            child: Text(person == null ? 'Create' : 'Update'),
          ),
        ],
      );
    },
  );
}

class PersonPage extends ConsumerWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example 5'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = await createOrUpdatePersonDialog(context);
          if (person != null) {
            final personChangeNotifier = ref.read(personChangeNotifierProvider);
            personChangeNotifier.add(person);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final personChangeNotifier = ref.watch(personChangeNotifierProvider);
          return ListView.builder(
            itemCount: personChangeNotifier.count,
            itemBuilder: ((context, index) {
              final person = personChangeNotifier.people[index];

              return ListTile(
                title: GestureDetector(
                  onTap: () async {
                    final updatedPerson = await createOrUpdatePersonDialog(
                      context,
                      person,
                    );

                    if (updatedPerson != null) {
                      personChangeNotifier.update(updatedPerson);
                    }
                  },
                  child: Text(person.displayName),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
