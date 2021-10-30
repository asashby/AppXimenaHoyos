import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';

class SettingUpPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => SettingUpPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Container(
        padding: EdgeInsets.all(28),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Datos adicionales",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SettingUpForm(),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 30),
                child: MaterialButton(
                  height: 60,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Siguiente",
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {},
                  color: Theme.of(context).buttonColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingUpForm extends StatelessWidget {
  final ages = List<String>.generate(73, (index) => (index + 18).toString());

  final weight = List<String>.generate(111, (index) => (index + 40).toString());

  final height =
      List<String>.generate(111, (index) => (index + 100).toString());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectorDropDown(items: ages, hint: "Edad"),
        SelectorDropDown(
          items: weight,
          hint: "Peso",
          sufix: "kg",
        ),
        SelectorDropDown(
          items: height,
          hint: "Altura",
          sufix: "m",
        ),
      ],
    );
  }
}

class SelectorDropDown extends StatelessWidget {
  const SelectorDropDown(
      {Key? key, required this.items, required this.hint, this.sufix = ''})
      : super(key: key);

  final List<String> items;
  final String hint;
  final String sufix;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          dropdownColor: Theme.of(context).backgroundColor,
          items: items
              .map((e) => DropdownMenuItem(
                    child: Text(
                      (e + " " + sufix).trim(),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    value: e,
                  ))
              .toList(),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
