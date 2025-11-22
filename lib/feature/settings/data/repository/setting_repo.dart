import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:easacc_task/core/errors/exceptions.dart';
import 'package:easacc_task/feature/settings/data/data_source/remote_data_cource.dart';
import 'package:easacc_task/feature/settings/data/models/devices_model.dart';
import 'package:easacc_task/feature/settings/data/models/wep_url.dart';
class SettingRepository {
  final WebViewRemoteDataSource remoteDataSource;
  SettingRepository({required this.remoteDataSource});

  Future<Either<Failure, WebViewUrlModel>> getWebViewUrl(String url) async {
    try {
      final result = await remoteDataSource.fetchWebViewUrl(url);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
// A stream subscription to manage scanning
  StreamSubscription? _scanSubscription;
// A method to watch devices periodically
  Stream<List<Device>> watchDevices() async* {
    while (true) {
      try {
        final devices = await remoteDataSource.fetchDevices();
        yield devices;
        await Future.delayed(Duration(seconds: 10));
      } catch (e) {
        log('Error in watchDevices stream: $e');
        yield [];
        await Future.delayed(Duration(seconds: 10));
      }
    }
  }

  void dispose() {
    _scanSubscription?.cancel();
  }

}
