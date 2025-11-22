import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever;
  }

  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<bool> requestBluetoothPermissions() async {
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    return true;
  }
}
