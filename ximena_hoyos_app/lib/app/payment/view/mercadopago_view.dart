import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MercadopagoView extends StatelessWidget {
  final String url;
  const MercadopagoView({ Key? key, required this.url }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
    );
  }
}