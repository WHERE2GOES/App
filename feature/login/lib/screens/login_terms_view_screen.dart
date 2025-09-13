import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginTermsViewScreen extends StatefulWidget {
  const LoginTermsViewScreen({super.key, this.html});

  final String? html;

  @override
  State<LoginTermsViewScreen> createState() => _LoginTermsViewScreenState();
}

class _LoginTermsViewScreenState extends State<LoginTermsViewScreen> {
  final controller = WebViewController();
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    final html = widget.html;
    if (!isInitialized && html != null) {
      isInitialized = true;
      controller.loadHtmlString(html);
    }

    return SafeArea(child: WebViewWidget(controller: controller));
  }
}
