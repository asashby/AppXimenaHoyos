import 'package:flutter/material.dart';

class ChallengeAttributeView extends StatelessWidget {
  final String value;
  final String title;
  const ChallengeAttributeView({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}