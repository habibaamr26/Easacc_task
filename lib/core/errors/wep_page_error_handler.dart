import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// WebView Error Handler - manage all possible errors
class WebViewErrorHandler {

  /// Handle WebResource errors
  static void handleWebResourceError(
      BuildContext context, WebResourceError error) {
    debugPrint(' WebView Error: ${error.description}');

    final message = _getErrorMessage(error);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  /// Map error types to short messages
  static String _getErrorMessage(WebResourceError error) {
    switch (error.errorType) {
      case WebResourceErrorType.hostLookup:
      case WebResourceErrorType.connect:
        return 'Failed to connect. Check your internet.';
      case WebResourceErrorType.timeout:
        return 'Connection timed out.';
      case WebResourceErrorType.fileNotFound:
        return 'Page not found (404).';
      case WebResourceErrorType.authentication:
        return 'Authentication error.';
      case WebResourceErrorType.unsupportedScheme:
        return 'Unsupported URL scheme.';
      case WebResourceErrorType.badUrl:
        return 'Invalid URL.';
      default:
        return error.description;
    }
  }

  /// Validate and fix URL
  static String? validateAndFormatUrl(String url) {
    if (url.isEmpty) return null;
    var trimmed = url.trim();
    if (!trimmed.startsWith('http')) trimmed = 'https://$trimmed';
    try {
      final uri = Uri.parse(trimmed);
      if (uri.host.isEmpty) return null;
      return trimmed;
    } catch (_) {
      return null;
    }
  }

  /// Build simple error page
  static Widget buildErrorPage({
    required String title,
    required String message,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(message, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Handle navigation requests
  static NavigationDecision handleNavigationRequest(NavigationRequest request, BuildContext context) {
    if (request.url.contains('javascript:') || request.url.contains('data:')) {
      _showDialog(context, 'Unsafe link', 'This link is blocked for security.');
      return NavigationDecision.prevent;
    }
    if (request.url.endsWith('.pdf') || request.url.endsWith('.zip') || request.url.endsWith('.apk')) {
      _showDialog(context, 'Download file', 'Do you want to download:\n${request.url}');
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  static void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  /// Handle HTTP errors
  static void handleHttpError(BuildContext context, int statusCode) {
    final message = {
      400: 'Bad request (400)',
      401: 'Unauthorized (401)',
      403: 'Forbidden (403)',
      404: 'Not found (404)',
      500: 'Server error (500)',
      502: 'Bad gateway (502)',
      503: 'Service unavailable (503)',
    }[statusCode] ?? 'HTTP Error ($statusCode)';

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red.shade700),
      );
    }
  }
}
