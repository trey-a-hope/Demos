import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsPage extends StatefulWidget {
  final User user;

  const SettingsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              MdiIcons.email,
              color: Colors.orange.shade900,
            ),
            title: const Text('Link Email/Password'),
            onTap: () async {
              // Get email credential.
              final emailCredential = EmailAuthProvider.credential(
                email: 'johndoe@gmail.com',
                password: '123456',
              );

              // Link email account to this anonymous account.
              await user.linkWithCredential(emailCredential);
            },
          ),
          ListTile(
            leading: Icon(
              MdiIcons.google,
              color: Colors.green,
            ),
            title: const Text('Link Google'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              MdiIcons.facebook,
              color: Colors.blue.shade900,
            ),
            title: const Text('Link Facebook'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              MdiIcons.apple,
              color: Colors.red,
            ),
            title: const Text('Link Apple'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              MdiIcons.twitter,
              color: Colors.lightBlue,
            ),
            title: const Text('Link Twitter'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              MdiIcons.phone,
              color: Colors.grey,
            ),
            title: const Text('Link Phone'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              MdiIcons.microsoft,
              color: Colors.red,
            ),
            title: const Text('Link Microsoft'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              MdiIcons.yahoo,
              color: Colors.purple,
            ),
            title: const Text('Link Yahoo'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              MdiIcons.github,
              color: Colors.black,
            ),
            title: const Text('Link GitHub'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
