import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.devices_other, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text("No devices found"),
          SizedBox(height: 8),
          Text(
            "Make sure WiFi and Bluetooth are enabled",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
 
  }
}
