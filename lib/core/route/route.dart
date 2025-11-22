import 'package:easacc_task/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:easacc_task/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:easacc_task/feature/settings/data/data_source/remote_data_cource.dart';
import 'package:easacc_task/feature/settings/data/repository/setting_repo.dart';
import 'package:easacc_task/feature/settings/presentation/cubit/setting_cubit.dart';
import 'package:easacc_task/feature/settings/presentation/views/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:easacc_task/feature/auth/presentation/views/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                GoogleAuthCubit(GoogleSignInService()),
            child: const LoginScreen(),
          ),
        );
      case '/SettingsPage':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => SettingCubit(
              repository: SettingRepository(
                remoteDataSource: WebViewRemoteDataSource(),
              ),
            ),
            child: SettingsPage(),
          ),
        );

       

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
