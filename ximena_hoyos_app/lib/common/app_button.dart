import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function? onPressed;
  final String? title;

  const AppButton({
    Key? key,
    this.onPressed,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: Theme.of(context).primaryColorDark,
      disabledColor: Theme.of(context).primaryColorDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      onPressed: this.onPressed as void Function()?,
      height: 88,
      minWidth: double.infinity,
      child: Text(
        this.title!,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
