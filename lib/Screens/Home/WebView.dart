import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    print("Initializing WebView with URL: ${widget.url}");
    try {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {
              print("Page started loading: $url");
            },
            onPageFinished: (url) {
              print("Page finished loading: $url");
            },
            onWebResourceError: (error) {
              print("Web resource error: ${error.description}");
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    } catch (e) {
      print("Exception occurred while loading WebView: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building WebViewScreen for ${widget.title}");
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),          backgroundColor: const Color(0xFF4A00E0),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
