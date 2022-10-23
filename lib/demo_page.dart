import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// Flutter home page url.
  final Uri _webUrl = Uri.parse('https://flutter.dev');

  //TODO
  final Uri _emailUrl =
      Uri.parse('mailto:smith@example.org?subject=News&body=New%20plugin');

  //TODO
  final Uri _phoneUrl = Uri.parse('tel:+1-937-305-2027');

  //TODO
  final Uri _smsUrl = Uri.parse('sms:9371234567');

  //TODO
  final Uri _fileUrl = Uri.parse('file:/home');

  /// Launch the URL.
  Future<void> _launchUrl({required Uri uri}) async {
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
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
              onPressed: () => _launchUrl(uri: _webUrl),
              child: Text(
                'Open Webview',
              ),
            ),
            ElevatedButton(
              onPressed: () => _launchUrl(uri: _emailUrl),
              child: Text(
                'Open Email',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
