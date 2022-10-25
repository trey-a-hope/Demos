import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  //TODO: Open file on desktop.
  /// Open file Uri, (for desktop only).
  final Uri _fileUri =
      Uri.parse('file:/Users/treyhope/Desktop/T_H_PROOF-1200.jpg');

  /// Force error Uri.
  final Uri _errorUri = Uri.parse('file:/home');

  /// Launch the URL.
  Future<void> _launchUrl({required Uri uri}) async {
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
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
            //TODO: Display snackbar showing error.
            ElevatedButton(
              onPressed: () => _launchUrl(uri: _errorUri),
              child: Text(
                'Throw Error',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
