import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm_wrapper/flutter_fcm_wrapper.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';

class NotifyGangScreen extends StatefulWidget {
  const NotifyGangScreen({Key? key}) : super(key: key);

  @override
  State<NotifyGangScreen> createState() => _NotifyGangScreenState();
}

class _NotifyGangScreenState extends State<NotifyGangScreen> {
  FlutterFCMWrapper flutterFCMWrapper = const FlutterFCMWrapper(
    apiKey: firebaseCloudMessagingAPIKey,
    enableLog: true,
    enableServerRespondLog: true,
  );

  void sendNotifications() async {
    try {
      // Fetch all users excluding the current user.
      final usersSnapshot = await FirebaseFirestore.instance
          .collection('ig_clone_users')
          .where('uid', isNotEqualTo: AuthMethods().getCurrentUid())
          .get();

      // Extract users from snapshot docs.
      var users = usersSnapshot.docs.map((e) => User.fromSnap(e)).toList();

      // Filter out any users who don't have a token.
      users = users.where((e) => e.token != null).toList();

      // Map users to tokens.
      final userRegistrationTokens = users.map((e) => e.token!).toList();

      await flutterFCMWrapper.sendMessageByTokenID(
        userRegistrationTokens: userRegistrationTokens,
      );

      showSnackbar(context, message: 'Gang notified.', label: 'Send Again?');
    } catch (e) {
      showSnackbar(context, message: e.toString());
    }
  }

  void showSnackbar(BuildContext context,
      {required String message, String? label}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: label ?? '',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.notification_add,
            color: Colors.white,
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            'Notify The Gang?',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              sendNotifications();
            },
            child: const Text('Notify'),
          )
        ],
      );
}
