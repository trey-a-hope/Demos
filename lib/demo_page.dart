import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patreon/user_model.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    //TODO: Call method...
  }

  void _create() async {
    //Create user.
    UserModel user = UserModel(
      username: 'trey.codes',
      age: 29,
      money: 799.99,
      isOnline: true,
      created: DateTime.now(),
      friends: [
        'Keisha',
        'Nina',
        'Brandy',
        'Rose',
      ],
    );

    //Create document reference.
    DocumentReference userDocRef = _usersDB.doc();

    //Update the id of the user.
    user.id = userDocRef.id;

    //Set document reference with user object.
    await userDocRef.set(user.toMap());
  }

  Future<UserModel> _read({required String id}) async {
    //Retrieve user from collection via id.
    DocumentSnapshot<Object?> data = await _usersDB.doc(id).get();

    //Convert DocumentSnapshot to UserModel.
    UserModel user = UserModel.fromDoc(data: data);

    return user;
  }

  void _update({required String id, required Map<String, Object?> data}) async {
    //Update data on the specified user doc.
    await _usersDB.doc(id).update(data);
  }

  void _delete({required String id}) async {
    //Delete the specified user doc.
    await _usersDB.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Container(),
    );
  }
}
