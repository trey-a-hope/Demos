import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

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
            Divider(),
            Text('Latitude: ${widget.position.latitude}'),
            Divider(),
            Text('Longitude: ${widget.position.longitude}'),
            Divider(),
            Text('Altitude: ${widget.position.altitude}'),
            Divider(),
            Text('Floor: ${widget.position.floor}'),
            Divider(),
            Text('Heading: ${widget.position.heading}'),
            Divider(),
            Text('Is Mocked: ${widget.position.isMocked}'),
            Divider(),
            Text('Speed: ${widget.position.speed}'),
            Divider(),
            Text('Speed Accuracy: ${widget.position.speedAccuracy}'),
            Divider(),
            Text(
                'Timestamp: ${DateFormat.yMMMd().format(widget.position.timestamp!)}'),
          ],
        ),
      ),
    );
  }
}
