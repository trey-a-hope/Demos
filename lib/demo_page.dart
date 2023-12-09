import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final int money;
  final int age;
  final String city;
  final String state;
  final int zip;
  final String? uid;
  final String address;

  User({
    this.uid,
    required this.address,
    required this.name,
    required this.money,
    required this.age,
    required this.city,
    required this.state,
    required this.zip,
  });
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  final usersColRef = FirebaseFirestore.instance.collection('users');

  final TextStyle _textStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Solution'),
      ),
      body: SafeArea(
        child: _secondPart(),
      ),
    );
  }

  User _convertDocToUser(QueryDocumentSnapshot<Object?> doc) {
    return User(
      uid: doc.get('uid'),
      address: doc.get('location')['address'],
      name: doc.get('name'),
      money: doc.get('money'),
      age: doc.get('age'),
      city: doc.get('location')['city'],
      state: doc.get('location')['state'],
      zip: doc.get('location')['zip'],
    );
  }

  Future<User> _getRandomPerson() async {
    // Send http request.
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));

    // Convert body to json.
    final results = json.decode(response.body);

    if (results['results'][0]['location']['postcode'] is String) {
      throw Exception('Zip code is not an int');
    }

    return User(
      name: results['results'][0]['name']['first'],
      money: 200,
      age: Random().nextInt(21) + 20,
      city: results['results'][0]['location']['city'],
      state: results['results'][0]['location']['state'],
      zip: results['results'][0]['location']['postcode'],
      address:
          '${results['results'][0]['location']['street']['number']} ${results['results'][0]['location']['street']['name']}',
    );
  }

  Widget _firstPart() {
    return Center(
      child: Text('My Solution!', style: _textStyle),
    );
  }

  Widget _secondPart() {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: usersColRef.snapshots(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return snapshots.data!.docs.isEmpty
                    ? Center(
                        child: Text('Where is your data?', style: _textStyle),
                      )
                    : ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index];
                          var user = _convertDocToUser(data);
                          return ListTile(
                            title: Text('${user.name} - ${user.uid}',
                                style: _textStyle),
                            subtitle: Text(
                              'Age: ${user.age}\nMoney: ${Money.fromInt(user.money * 100, code: 'USD')}\nLocation: ${user.address}, ${user.city} ${user.state} ${user.zip}',
                            ),
                          );
                        },
                      );
              } else if (snapshots.hasError) {
                return Center(
                  child: Text('Error: ${snapshots.error}'),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        ElevatedButton(
          child: const Text('Add Random User'),
          onPressed: () async {
            try {
              var user = await _getRandomPerson();

              DocumentReference userDocRef = usersColRef.doc();

              userDocRef.set(
                {
                  'uid': userDocRef.id,
                  'name': user.name,
                  'money': user.money,
                  'age': user.age,
                  'location': {
                    'address': user.address,
                    'city': user.city,
                    'state': user.state,
                    'zip': user.zip,
                  }
                },
              );
            } catch (e) {}
          },
        ),
      ],
    );
  }
}
