import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionDetailsWidget extends StatefulWidget {
  PositionDetailsWidget({
    Key? key,
    required this.position,
  }) : super(key: key);

  final Position position;

  @override
  State<PositionDetailsWidget> createState() => _PositionDetailsWidgetState();
}

class _PositionDetailsWidgetState extends State<PositionDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text('Accuracy: ${widget.position.accuracy}'),
            Text('Latitude: ${widget.position.latitude}'),
            Text('Longitude: ${widget.position.longitude}'),
            Text('Altitude: ${widget.position.altitude}'),
            Text('Floor: ${widget.position.floor}'),
            Text('Heading: ${widget.position.heading}'),
            Text('Is Mocked: ${widget.position.isMocked}'),
            Text('Speed: ${widget.position.speed}'),
            Text('Speed Accuracy: ${widget.position.speedAccuracy}'),
            Text('Timestamp: ${widget.position.timestamp}'),
          ],
        ),
      ),
    );
  }
}
