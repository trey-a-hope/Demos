import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:patreon/position_details_.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  //Contains detailed location information about the current position.
  Position? _currentPosition;

  //Contains detailed location information about the last known position.
  Position? _lastKnownPosition;

// Fires whenever the location services are disabled/enabled in
// the notification bar or in the device settings. Returns
// ServiceStatus.enabled when location services are enabled and
// returns ServiceStatus.disabled when location services are disabled.
  StreamSubscription<ServiceStatus> _serviceStatusStream =
      Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
    switch (status) {
      case ServiceStatus.disabled:
        print('Service status disabled.');
        break;
      case ServiceStatus.enabled:
        print('Service status enabled.');
        break;
    }
  });

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    try {
      await _getPermissions();

      // Returns the current position.
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Returns the last known position.
      _lastKnownPosition = await Geolocator.getLastKnownPosition();

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _serviceStatusStream.cancel();

    super.dispose();
  }

  /// Get permission to use location services.
  Future<void> _getPermissions() async {
    // Determines if the location services are enabled.
    bool serviceEnabled;

    // Permission to access the device's location is denied, the App should try
    // to request permission using the `Geolocator.requestPermission()` method.
    // [denied],

    // Permission to access the device's location is permenantly denied. When
    // requestiong permissions the permission dialog will not been shown until
    // the user updates the permission in the App settings.
    // [deniedForever],

    // Permission to access the device's location is allowed only while
    // the App is in use.
    // [whileInUse],

    // Permission to access the device's location is allowed even when the
    // App is running in the background.
    // [always],

    // Permission status is cannot be determined. This permission is only
    // returned by the `Geolocator.checkPermission()` method on the web platform
    // for browsers that do not implement the Permission API (see https://developer.mozilla.org/en-US/docs/Web/API/Permissions_API).
    // [unableToDetermine]
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    // Returns a [Future] indicating if the user allows the App to access the device's location.
    permission = await Geolocator.checkPermission();

    switch (permission) {
      case LocationPermission.denied:
        // Permission to access the device's location is denied by the user.
        // You are free to request permission again (this is also the initial permission state).

        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
        break;
      case LocationPermission.deniedForever:
        // Permission to access the device's location is permenantly denied. When requesting
        // permissions the permission dialog will not been shown until the user updates the permission in the App settings.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      case LocationPermission.unableToDetermine:
        // Permission status is cannot be determined. This permission is only returned by the Geolocator.checkPermission()
        // method on the web platform for browsers that do not implement the Permission API (see https://developer.mozilla.org/en-US/docs/Web/API/Permissions_API).
        return Future.error(
            'Unable to determine permissions; location permissions denied by default.');
      case LocationPermission.whileInUse:
        // Permission to access the device's location is allowed only while the App is in use.
        break;
      case LocationPermission.always:
        // Permission to access the device's location is allowed even when the App is running in the background.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocator'),
      ),
      body: Column(
        children: [
          if (_currentPosition != null) ...<Widget>[
            Text('Current Position'),
            PositionDetailsWidget(position: _currentPosition!),
          ],
          if (_lastKnownPosition != null) ...<Widget>[
            Text('Last Known Position'),
            PositionDetailsWidget(position: _lastKnownPosition!),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => Geolocator.openAppSettings(),
                child: Text('Open App Settings'),
              ),
              ElevatedButton(
                onPressed: () => Geolocator.openLocationSettings(),
                child: Text('Open Location Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
