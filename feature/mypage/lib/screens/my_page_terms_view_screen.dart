import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyPageTermsViewScreen extends StatefulWidget {
  const MyPageTermsViewScreen({super.key, this.html});

  final String? html;

  @override
  State<MyPageTermsViewScreen> createState() => _MyPageTermsViewScreenState();
}

class _MyPageTermsViewScreenState extends State<MyPageTermsViewScreen> {
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
