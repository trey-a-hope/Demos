import 'package:flutter/material.dart';
import 'package:patreon/authenticated_page.dart';
import 'package:patreon/unauthenticated_page.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _isAuthenticated = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated ? AuthenticatedPage() : UnauthenticatedPage();
  }
}
