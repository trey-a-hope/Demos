import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// Open web Uri.
  final Uri _webUri = Uri.parse('https://flutter.dev');

  /// Open email Uri.
  final Uri _emailUri = Uri(
    scheme: 'mailto',
    path: 'trey.a.hope@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Example Subject',
      'body': 'Good evening, to whome this may concern...',
    }),
  );

  /// Open phone Uri.
  final Uri _callPhoneUri = Uri.parse('tel:+1-937-123-4567');

  /// Open text message Uri.
  final Uri _textPhoneUri = Uri.parse('sms:5550101234');

  /// Open file Uri.
  final Uri _fileUri = Uri.file('/Users/treyhope/Desktop/hello_world.txt');

  /// Launch the URL.
  Future<void> _launchUrl({required Uri uri}) async {
    if (!await canLaunchUrl(uri)) {
      throw 'Could not launch $uri';
    }

    await launchUrl(uri);
  }

  /// Create key value pairs for query params.
  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('URL Launcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _launchUrl(uri: _webUri),
              child: Text(
                'Open a webview',
              ),
            ),
            ElevatedButton(
              onPressed: () => _launchUrl(uri: _emailUri),
              child: Text(
                'Send an email',
              ),
            ),
            ElevatedButton(
              onPressed: () => _launchUrl(uri: _textPhoneUri),
              child: Text(
                'Send a text message',
              ),
            ),
            ElevatedButton(
              onPressed: () => _launchUrl(uri: _callPhoneUri),
              child: Text(
                'Call a phone number',
              ),
            ),
            ElevatedButton(
              onPressed: () => _launchUrl(uri: _fileUri),
              child: Text(
                'Open File',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
