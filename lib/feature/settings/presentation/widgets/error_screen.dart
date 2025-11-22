
import 'package:easacc_task/feature/settings/presentation/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text("Error: ${message}"),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<SettingCubit>().startWatchingDevices();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
  }
}
