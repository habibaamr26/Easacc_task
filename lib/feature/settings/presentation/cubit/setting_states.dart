import 'package:easacc_task/feature/settings/data/models/devices_model.dart';

abstract class SettingState {}

class SettingInitial extends SettingState {}

class WebViewUrlLoaded extends SettingState {
  final String url;
  WebViewUrlLoaded(this.url);
}

class WebViewLoading extends SettingState {}

class WebViewErrorState extends SettingState {
  final String message;
  WebViewErrorState(this.message);
}

class DeviceLoading extends SettingState {}

class DeviceLoaded extends SettingState {
  final List<Device> devices;

  DeviceLoaded(this.devices);
}

class DeviceError extends SettingState {
  final String message;

  DeviceError(this.message);
}
