import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // The app name. CFBundleDisplayName on iOS, application/label on Android.
  String? _appName;

  // The package name. bundleIdentifier on iOS, getPackageName on Android.
  String? _packageName;

  // The package version. CFBundleShortVersionString on iOS, versionName on Android.
  String? _version;

  // The build number. CFBundleVersion on iOS, versionCode on Android.
  String? _buildNumber;

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    // Retrieves package information from the platform. The result is cached.
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // Assign package info to global variables.
    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;

    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Info Plus'),
      ),
      body: Column(
        children: [
          _appName != null
              ? _buildPackageInfoListTile(
                  title: _appName!, subtitle: 'App Name')
              : SizedBox.shrink(),
          _packageName != null
              ? _buildPackageInfoListTile(
                  title: _packageName!, subtitle: 'Package Name')
              : SizedBox.shrink(),
          _version != null
              ? _buildPackageInfoListTile(title: _version!, subtitle: 'Version')
              : SizedBox.shrink(),
          _buildNumber != null
              ? _buildPackageInfoListTile(
                  title: _buildNumber!, subtitle: 'Build Number')
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  /// Create a ListTile with custom title and subtitle.
  ListTile _buildPackageInfoListTile({
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(Icons.check),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
