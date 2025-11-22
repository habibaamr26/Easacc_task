class Device {
  final String name;
  final String id;
  final DeviceType type;

  Device({
    required this.name,
    required this.id,
    required this.type,
  });
}
enum DeviceType { wifi, bluetooth, printer }
