import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;

  const BaseScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SafeArea(child: child),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.0,
                0.4
              ],
                  colors: [
                Theme.of(context).backgroundColor,
                Color(0xFF121212)
              ]))),
    );
  }
}
