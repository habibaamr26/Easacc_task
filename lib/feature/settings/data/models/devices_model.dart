class Device {
  final String name;
  final String id;
  final DeviceType type;

  Device({
    required this.name,
    required this.id,
    required this.type,
  });
   @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}
enum DeviceType { wifi, bluetooth, printer }
