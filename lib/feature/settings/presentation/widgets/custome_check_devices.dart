
import 'package:easacc_task/feature/settings/presentation/cubit/setting_cubit.dart';
import 'package:easacc_task/feature/settings/presentation/cubit/setting_states.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/drop_down_widget.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/empty_screen.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/error_screen.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/loading_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CustomCheckDevices extends StatelessWidget {
  const CustomCheckDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state is DeviceLoading) {
          return const LoadingScreen();
        }
        if (state is DeviceError) {
          return ErrorScreen(message: state.message);
        }

        if (state is DeviceLoaded) {
          final devices = state.devices;
          if (devices.isEmpty) {
            return const EmptyScreen();
          }

          return DropDownWidget(devices: devices);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
