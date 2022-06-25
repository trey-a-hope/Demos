import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('Users');

  // @override
  // Future<UserModel> getCurrentUser() async {
  //   try {
  //     final User firebaseUser = _auth.currentUser;
  //     final DocumentSnapshot documentSnapshot =
  //         await _usersDB.doc(firebaseUser.uid).get();
  //     return UserModel.fromDoc(ds: documentSnapshot);
  //   } catch (e) {
  //     throw Exception('Could not fetch user at this time.');
  //   }
  // }

  Future<void> signOut() {
    return _auth.signOut();
  }

  Stream<User?> onAuthStateChanged() {
    return _auth.authStateChanges();
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // @override
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Future<void> updatePassword({@required String password}) async {
  //   try {
  //     User firebaseUser = _auth.currentUser;
  //     await firebaseUser.updatePassword(password);
  //     return;
  //   } catch (e) {
  //     if (e.message != null) {
  //       throw Exception(
  //         e.message,
  //       );
  //     } else {
  //       throw Exception(
  //         e.toString(),
  //       );
  //     }
  //   }
  // }

  // @override
  // Future<void> deleteUser({String userID}) async {
  //   try {
  //     User firebaseUser = _auth.currentUser;
  //     await firebaseUser.delete();
  //     await _usersDB.doc(userID).delete();
  //     return;
  //   } catch (e) {
  //     throw Exception(
  //       e.toString(),
  //     );
  //   }
  // }

  // @override
  // Future<void> resetPassword({@required String email}) async {
  //   try {
  //     return await _auth.sendPasswordResetEmail(email: email);
  //   } catch (e) {
  //     throw Exception(
  //       e.toString(),
  //     );
  //   }
  // }

  // @override
  // Future<void> updateEmail({@required String newEmail}) async {
  //   try {
  //     return await _auth.currentUser.updateEmail(newEmail);
  //   } catch (e) {
  //     if (e.message != null) {
  //       throw Exception(
  //         e.message,
  //       );
  //     } else {
  //       throw Exception(
  //         e.toString(),
  //       );
  //     }
  //   }
  // }
}
