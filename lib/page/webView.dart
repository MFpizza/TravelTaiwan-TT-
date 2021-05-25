import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;

  WebViewExample({@required this.url});

  @override
  WebViewExampleState createState() => WebViewExampleState(url: url);
}

class WebViewExampleState extends State<WebViewExample> {
  final String url;

  WebViewExampleState({@required this.url});

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: WebView(
          initialUrl: url,
        ));
  }
}
