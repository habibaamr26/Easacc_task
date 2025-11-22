import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:easacc_task/core/errors/exceptions.dart';
import 'package:easacc_task/feature/settings/data/models/devices_model.dart';
import 'package:easacc_task/feature/settings/data/models/wep_url.dart';
import 'package:easacc_task/feature/settings/data/repository/setting_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_states.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingRepository repository;
  SettingCubit({required this.repository}) : super(SettingInitial());

// Method to update the WebView URL
  Future<void> updateUrl(String url) async {
    emit(WebViewLoading());
    try {
      final Either<Failure, WebViewUrlModel> result = await repository
          .getWebViewUrl(url);

      result.fold(
        (failure) => emit(WebViewErrorState(failure.message)),
        (entity) => emit(WebViewUrlLoaded(entity.url)),
      );
    } catch (e) {
      emit(WebViewErrorState(e.toString()));
    }
  }

  StreamSubscription<List<Device>>? _deviceSubscription;
  // Method to start watching devices
  void startWatchingDevices() {
    emit(DeviceLoading());

    _deviceSubscription = repository.watchDevices().listen(
      (devices) {
        if (devices.isEmpty) {
          emit(DeviceLoaded([]));
        } else {
          emit(DeviceLoaded(devices));
        }
      },
      onError: (error) {
        emit(DeviceError(error.toString()));
      },
    );
  }

  void stopWatchingDevices() {
    _deviceSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _deviceSubscription?.cancel();
    repository.dispose();
    return super.close();
  }
}
