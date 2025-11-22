// Web View Screen
import 'package:easacc_task/core/errors/wep_page_error_handler.dart';
import 'package:easacc_task/feature/settings/presentation/cubit/setting_cubit.dart';
import 'package:easacc_task/feature/settings/presentation/cubit/setting_states.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/app_bar.dart';
import 'package:easacc_task/feature/settings/presentation/widgets/loading_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            print('WebView Error: ${error.description}');
            WebViewErrorHandler.handleWebResourceError(context, error);
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state is WebViewLoading) {
          return const LoadingScreen();
        }

        if (state is WebViewUrlLoaded) {
          controller.loadRequest(Uri.parse(state.url));

          return Scaffold(
            appBar: customAppBar(context, 'Web View'),
            body: WebViewWidget(controller: controller),
          );
        }

        return const Scaffold(body: Center(child: Text("No URL Loaded")));
      },
    );
  }
}
