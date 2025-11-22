import 'package:easacc_task/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:easacc_task/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:easacc_task/feature/settings/data/data_source/remote_data_cource.dart';
import 'package:easacc_task/feature/settings/data/repository/setting_repo.dart';
import 'package:easacc_task/feature/settings/presentation/cubit/setting_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  // تسجيل جميع الـ dependencies قبل أي استخدام
  authDependencyInjectionInit();
  settingDependencyInjectionInit();
}

void authDependencyInjectionInit() {
  // تسجيل FirebaseAuth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // تسجيل GoogleSignIn
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);

  // تسجيل GoogleSignInService
  getIt.registerLazySingleton<GoogleSignInService>(
    () => GoogleSignInService(
      auth: getIt<FirebaseAuth>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  // تسجيل GoogleAuthCubit
  getIt.registerFactory<GoogleAuthCubit>(
    () => GoogleAuthCubit(getIt<GoogleSignInService>()),
  );
}

void settingDependencyInjectionInit() {
  // تسجيل Data Source
  getIt.registerLazySingleton<WebViewRemoteDataSource>(
    () => WebViewRemoteDataSource(),
  );

  // تسجيل Repository
  getIt.registerLazySingleton<SettingRepository>(
    () => SettingRepository(remoteDataSource: getIt<WebViewRemoteDataSource>()),
  );

  // تسجيل Cubit
  getIt.registerFactory<SettingCubit>(
    () => SettingCubit(repository: getIt<SettingRepository>()),
  );
}
