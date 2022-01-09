import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String username;
  int age;
  double money;
  bool isOnline;
  DateTime created;
  List<dynamic> friends;

  UserModel({
    this.id,
    required this.username,
    required this.age,
    required this.money,
    required this.isOnline,
    required this.created,
    required this.friends,
  });

  factory UserModel.fromDoc({required DocumentSnapshot data}) {
    return UserModel(
      id: data['id'],
      username: data['username'],
      age: data['age'],
      money: data['money'],
      isOnline: data['isOnline'],
      created: data['created'].toDate(),
      friends: data['friends'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'age': age,
      'money': money,
      'isOnline': isOnline,
      'created': created,
      'friends': friends,
    };
  }
}
