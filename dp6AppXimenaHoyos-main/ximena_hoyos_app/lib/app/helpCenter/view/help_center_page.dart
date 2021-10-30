import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

class HelpCenterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HelpCenterPage());
  }

  Widget build(BuildContext context) {
    return BaseScaffold(
        child: BaseView(
      title: "Politicas de \ncookies",
      sliver: SliverFillRemaining(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.35),
          ),
        ),
      ),
    ));
  }
}
