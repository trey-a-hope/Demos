import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();

  runApp(MyApp(status: status));
}

class MyApp extends StatelessWidget {
  final TrackingStatus status;

  MyApp({required this.status});

  @override
  Widget build(BuildContext context) {
    String statusText;

    switch (status) {
      case TrackingStatus.authorized:
        statusText = 'Tracking Status Authorized';
        break;
      case TrackingStatus.denied:
        statusText = 'Tracking Status Denied';
        break;
      case TrackingStatus.notDetermined:
        statusText = 'Tracking Status Not Determined';
        break;
      case TrackingStatus.notSupported:
        statusText = 'Tracking Status Not Supported';
        break;
      case TrackingStatus.restricted:
        statusText = 'Tracking Status Restricted';
        break;
      default:
        statusText = 'You should not see this...';
        break;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('App Tracking Transparancy')),
        body: Center(
          child: Text(statusText),
        ),
      ),
    );
  }
}
