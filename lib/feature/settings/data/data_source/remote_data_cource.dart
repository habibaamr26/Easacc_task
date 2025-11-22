import 'dart:async';
import 'dart:developer';
import 'package:easacc_task/core/utils/permission_helper.dart';
import 'package:easacc_task/feature/settings/data/models/devices_model.dart';
import 'package:easacc_task/feature/settings/data/models/wep_url.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WebViewRemoteDataSource {
  Future<WebViewUrlModel> fetchWebViewUrl(String url) async {
    return WebViewUrlModel(url: url);
  }

  StreamController<List<Device>>? _bleStreamController;

  Future<List<Device>> fetchDevices() async {
    Set<Device> devices = {};
    bool _isScanning = false;
    // Scan WiFi networks
    try {
      if (!await PermissionHelper.requestLocationPermission()) {
        log('Location permission denied');
        return devices.toList();
      }

      if (!await PermissionHelper.isLocationServiceEnabled()) {
        log('Location service disabled');
        return devices.toList();
      }
      // Scan WiFi networks
      List<WifiNetwork> wifiNetworks = await WiFiForIoTPlugin.loadWifiList();
      log('WiFi scan completed with ${wifiNetworks.length} networks found');
      devices.addAll(
        wifiNetworks
            .map(
              (e) => Device(
                name: e.ssid ?? "Unknown WiFi",
                id: e.bssid ?? "Unknown BSSID",
                type: DeviceType.wifi,
              ),
            )
            .toSet(), // to prevent duplicates
      );
      log('WiFi devices added: ${devices.length}');
    } catch (e) {
      log('WiFi scan failed: $e');
    }

    try {
      log('Bluetooth scan started');

      await PermissionHelper.requestBluetoothPermissions();

      bool isBluetoothOn = await FlutterBluePlus.isOn;
      if (!isBluetoothOn) {
        log('BLE scan failed: Bluetooth is OFF');
      } else {
        if (FlutterBluePlus.isScanningNow) {
          // Stop any ongoing scan before starting a new one to prevent crashes
          // problem face me here
          log('Stopping previous scan...');
          await FlutterBluePlus.stopScan();
          await Future.delayed(const Duration(milliseconds: 500));
        }
        _isScanning = true;
        await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
        await Future.delayed(const Duration(seconds: 4, milliseconds: 500));
        final results = await FlutterBluePlus.scanResults.first;

        final bleDevices = results
            .map((r) {
              final name = r.device.platformName.isNotEmpty
                  ? r.device.platformName
                  : r.device.remoteId.str;

              return Device(
                name: name,
                id: r.device.remoteId.str,
                type: DeviceType.bluetooth,
              );
            })
            .toSet()
            .toList();

        devices.addAll(bleDevices);
        if (_isScanning && FlutterBluePlus.isScanningNow) {
          await FlutterBluePlus.stopScan();
          _isScanning = false;
        }
      }
    } catch (e) {
      log('BLE scan failed: $e');
      _isScanning = false;

      try {
        if (FlutterBluePlus.isScanningNow) {
          await FlutterBluePlus.stopScan();
        }
      } catch (e) {
        log('Error stopping scan: $e');
      }
    }

    return devices.toList();
  }

  void dispose() {
    _bleStreamController?.close();
  }
}
