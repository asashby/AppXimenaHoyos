import 'package:flutter/material.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({
    Key? key,
    this.active = false,
    this.lock = false,
  }) : super(key: key);

  final bool active;
  final bool lock;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Visibility(
        visible: active || lock,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            lock ? Icons.lock : Icons.check,
            color: Theme.of(context).buttonColor,
          ),
        ),
      ),
    );
  }
}
