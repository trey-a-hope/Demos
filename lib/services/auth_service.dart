import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patreon/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('Users');

  Future<UserModel> getCurrentUser() async {
    try {
      final User firebaseUser = _auth.currentUser!;

      final DocumentSnapshot<UserModel> model = (await _usersDB
          .doc(firebaseUser.uid)
          .withConverter<UserModel>(
              fromFirestore: (snapshot, _) =>
                  UserModel.fromJson(snapshot.data()!),
              toFirestore: (user, _) => user.toJson())
          .get());

      UserModel user = model.data()!;

      return user;
    } catch (e) {
      throw Exception('Could not fetch user at this time.');
    }
  }

  Future<void> signOut() async {
    //Sign user out.
    return _auth.signOut();
  }

  Stream<User?> onAuthStateChanged() {
    return _auth.authStateChanges();
  }

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  void updatePassword({required String password}) async {
    try {
      User firebaseUser = _auth.currentUser!;
      firebaseUser.updatePassword(password);
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<void> deleteUser({required String userID}) async {
    try {
      User firebaseUser = _auth.currentUser!;
      await firebaseUser.delete();
      await _usersDB.doc(userID).delete();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
