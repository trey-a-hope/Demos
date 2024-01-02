import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm_wrapper/flutter_fcm_wrapper.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';
import 'package:instagram_clone_flutter/widgets/user_list_tile.dart';

class NotifyGangScreen extends StatefulWidget {
  const NotifyGangScreen({Key? key}) : super(key: key);

  @override
  State<NotifyGangScreen> createState() => _NotifyGangScreenState();
}

class _NotifyGangScreenState extends State<NotifyGangScreen> {
  bool _sendingNotification = false;

  List<User> _users = [];

  FlutterFCMWrapper flutterFCMWrapper = const FlutterFCMWrapper(
    apiKey: firebaseCloudMessagingAPIKey,
    enableLog: true,
    enableServerRespondLog: true,
  );

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    // Fetch all users excluding the current user.
    final usersSnapshot = await FirebaseFirestore.instance
        .collection('ig_clone_users')
        .where('uid', isNotEqualTo: AuthMethods().getCurrentUid())
        .get();

    setState(() =>
        _users = usersSnapshot.docs.map((e) => User.fromSnap(e)).toList());
  }

  void sendNotifications() async {
    try {
      setState(() => _sendingNotification = true);

      // Filter out any users who don't have a token.
      var users = _users.where((e) => e.token != null).toList();

      // Map users to tokens.
      final userRegistrationTokens = users.map((e) => e.token!).toList();

      await flutterFCMWrapper.sendMessageByTokenID(
        userRegistrationTokens: userRegistrationTokens,
        title: 'Ay Gang!',
        body: 'Just posted, show some luv!',
      );

      setState(() => _sendingNotification = false);
      showSnackbar(context, message: 'Gang notified.', label: 'Send Again?');
    } catch (e) {
      setState(() => _sendingNotification = false);
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
        onPressed: () => sendNotifications(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: const Text('The Gang'),
            ),
      body: SafeArea(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _users.length,
              itemBuilder: (_, index) => UserListTile(
                user: _users[index],
              ),
            ),
            Expanded(
              child: Center(
                child: _sendingNotification
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        onPressed: () {
                          sendNotifications();
                        },
                        icon: const Icon(Icons.notification_add),
                        label: const Text('Notify The Gang'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
