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
      body: Container(
        color: const Color(0xff121421),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                MdiIcons.email,
                color: Colors.orange.shade900,
              ),
              title: Text(
                'Link Email/Password',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
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
              title: Text(
                'Link Google',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                MdiIcons.facebook,
                color: Colors.blue.shade900,
              ),
              title: Text(
                'Link Facebook',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                MdiIcons.apple,
                color: Colors.red,
              ),
              title: Text(
                'Link Apple',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                MdiIcons.twitter,
                color: Colors.lightBlue,
              ),
              title: Text(
                'Link Twitter',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                MdiIcons.phone,
                color: Colors.grey,
              ),
              title: Text(
                'Link Phone',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                MdiIcons.microsoft,
                color: Colors.red,
              ),
              title: Text(
                'Link Microsoft',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                MdiIcons.yahoo,
                color: Colors.purple,
              ),
              title: Text(
                'Link Yahoo',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                MdiIcons.github,
                color: Colors.grey,
              ),
              title: Text(
                'Link GitHub',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
