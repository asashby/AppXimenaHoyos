import 'package:flutter/material.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({
    Key? key,
    this.active = false,
    this.coursePaid
  }) : super(key: key);

  final bool active;
  final int? coursePaid;

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
        visible: active || coursePaid == 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            coursePaid == 0 ? Icons.lock : Icons.check,
            color: Color(0xff95d100),
          ),
        ),
      ),
    );
  }
}
