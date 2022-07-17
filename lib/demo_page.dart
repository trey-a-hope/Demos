import 'dart:async';
import 'dart:io';
import 'package:geocode/geocode.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:patreon/position_details_.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// Contains detailed location information about the current position.
  Position? _currentPosition;

  Position? _selectedPosition;

  /// Fires whenever the location services are disabled/enabled in
  /// the notification bar or in the device settings. Returns
  /// ServiceStatus.enabled when location services are enabled and
  /// returns ServiceStatus.disabled when location services are disabled.
  late StreamSubscription<ServiceStatus> _serviceStatusStream;

  late StreamSubscription<Position> _positionStream;

  late LocationSettings _locationSettings;

  LocationAccuracyStatus? _accuracy;

  /// Text controllers for addresses.
  TextEditingController _aPositionAddressController = TextEditingController();
  TextEditingController _bPositionAddressController = TextEditingController();

  /// Used for converting an address into coordinates.
  final GeoCode _geoCoder = GeoCode();

  /// Query submission debouncer.
  Timer? _debounce;

  String? _selectedAddress;

  final NumberFormat _numberFormat = NumberFormat("###,###.##", "en_US");

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    try {
      await _getPermissions();

      // Returns the last known position. Note: getCurrentPosition() causes an app refresh to crash.
      _currentPosition = await Geolocator.getLastKnownPosition();

      // Returns a [Future] containing a [LocationAccuracyStatus] When the user has given
      // permission for approximate location, [LocationAccuracyStatus.reduced] will be returned,
      // if the user has given permission for precise location, [LocationAccuracyStatus.precise]
      // will be returned
      _accuracy = await Geolocator.getLocationAccuracy();

      if (Platform.isAndroid) {
        _locationSettings = AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100,
            forceLocationManager: true,
            intervalDuration: const Duration(seconds: 10),
            //(Optional) Set foreground notification config to keep the app alive
            //when going to the background
            foregroundNotificationConfig: const ForegroundNotificationConfig(
              notificationText:
                  "Example app will continue to receive your location even when you aren't using it",
              notificationTitle: "Running in Background",
              enableWakeLock: true,
            ));
      } else if (Platform.isIOS || Platform.isMacOS) {
        _locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.fitness,
          distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
          // Only set to true if our app will be started up in the background.
          showBackgroundLocationIndicator: false,
        );
      } else {
        _locationSettings = LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      }

      _serviceStatusStream =
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

      _positionStream =
          Geolocator.getPositionStream(locationSettings: _locationSettings)
              .listen((Position? position) {
        print(position == null
            ? 'Unknown'
            : '${position.latitude.toString()}, ${position.longitude.toString()}');
      });

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  /// Calculates the distance between the supplied coordinates in meters.
  double _getDistanceBetween({
    required Position a,
    required Position b,
  }) {
    return Geolocator.distanceBetween(
      a.latitude,
      a.longitude,
      b.latitude,
      b.longitude,
    );
  }

  /// Calculates the initial bearing between two points
  double _getBearingBetween({
    required Position a,
    required Position b,
  }) {
    return Geolocator.bearingBetween(
      a.latitude,
      a.longitude,
      b.latitude,
      b.longitude,
    );
  }

  @override
  void dispose() {
    _serviceStatusStream.cancel();
    _positionStream.cancel();
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

  void _submitQuery({required String query}) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(seconds: 2),
      () async {
        try {
          Coordinates coordinates =
              await _geoCoder.forwardGeocoding(address: query);

          _selectedAddress = query;

          _selectedPosition = Position(
            longitude: coordinates.longitude!,
            latitude: coordinates.latitude!,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
          );

          setState(() {});
        } catch (e) {
          print(e);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocator & Geocoder'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              if (_currentPosition != null) ...[
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Current Position',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      PositionDetailsWidget(position: _currentPosition!),
                    ],
                  ),
                )
              ],
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        _selectedAddress ?? 'Selected Position',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _selectedPosition == null
                        ? Text('Please Select a location...')
                        : PositionDetailsWidget(position: _selectedPosition!),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _aPositionAddressController,
              decoration: InputDecoration(
                hintText: 'Enter address for location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _submitQuery(
                    query: _aPositionAddressController.text,
                  ),
                ),
              ),
            ),
          ),
          if (_accuracy != null) ...[
            ListTile(
              leading: Icon(Icons.check),
              title: Text(_accuracy.toString()),
              subtitle: Text('Accuracy'),
            ),
          ],
          if (_selectedPosition != null) ...[
            ListTile(
              leading: Icon(Icons.check),
              title: Builder(builder: (context) {
                double distanceMiles = _getDistanceBetween(
                  a: _currentPosition!,
                  b: _selectedPosition!,
                );

                return Text(
                    '${_numberFormat.format(distanceMiles)} meters / ${_numberFormat.format(distanceMiles / 1609.344)} miles');
              }),
              subtitle: Text('Distance'),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Builder(builder: (context) {
                double bearingMiles = _getBearingBetween(
                  a: _currentPosition!,
                  b: _selectedPosition!,
                );

                return Text('${_numberFormat.format(bearingMiles)}');
              }),
              subtitle: Text('Bearing'),
            ),
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
