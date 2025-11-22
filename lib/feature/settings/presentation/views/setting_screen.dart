
import 'package:easacc_task/core/errors/wep_page_error_handler.dart';
import 'package:easacc_task/core/utils/app_text.dart';
import 'package:easacc_task/feature/settings/presentation/cubit/setting_cubit.dart';
import 'package:easacc_task/feature/settings/presentation/views/web_view.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/app_bar.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/custom_web_url.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/custome_check_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingCubit>().startWatchingDevices();
  }

  @override
  void dispose() {
  
    context.read<SettingCubit>().stopWatchingDevices();
    super.dispose();
  }

  final TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, AppText.settings),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // URL + open button
            CustomWebUrl(
              urlController: urlController,
              onPressed: () {
                _openWebView(context, urlController.text);
              },
            ),
      
            const SizedBox(height: 25),
            CustomCheckDevices(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _openWebView(BuildContext context, String text) {
    if (text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter a URL to proceed"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final url = WebViewErrorHandler.validateAndFormatUrl(text);
    if (url == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("enter valid URL: google.com"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<SettingCubit>().updateUrl(url);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          // to send the existing cubit instance
          value: context.read<SettingCubit>(),
          child: const WebViewPage(),
        ),
      ),
    );
  }
}
