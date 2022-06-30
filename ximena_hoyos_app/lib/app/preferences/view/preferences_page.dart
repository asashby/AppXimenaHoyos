import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/address/address.dart';
import 'package:ximena_hoyos_app/app/calculator/view/calculator_page.dart';
import 'package:ximena_hoyos_app/app/preferences/bloc/preferences_bloc.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/app/privacy/view/privacy_page.dart';
import 'package:ximena_hoyos_app/app/profile/view/profile_page.dart';

class PreferencePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => PreferencePage(),
    );
  }

  Widget build(BuildContext context) {
    return BlocListener<PreferenceBloc, PreferenceState>(
      listener: (context, state) {
        if (state is PreferenceStateLoading) {
        } else if (state is PreferenceStateError) {
          final snackbar = SnackBar(content: Text(state.error.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      child: BaseScaffold(
        child: BaseView(
          title: 'Perfil',
          sliver: SliverPadding(
            padding: const EdgeInsets.only(right: 24, left: 24, bottom: 60),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _PreferenceButton(
                  onPressed: () {
                    Navigator.of(context).push(ProfilePage.route());
                  },
                  title: 'Datos personales',
                ),
                _PreferenceButton(
                  // onPressed: () {
                  //   Navigator.of(context).push(AddressPage.route());
                  // },
                  title: 'Mis direcciones',
                ),
                _PreferenceButton(
                  title: 'Mis pedidos',
                ),
                _PreferenceButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(PrivacyPage.route(ContentType.terms));
                  },
                  title: 'Terminos y condiciones',
                ),
                _PreferenceButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(PrivacyPage.route(ContentType.privacy));
                  },
                  title: 'Politicas de privacidad',
                ),
                _PreferenceButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(CalculatorPage.route());
                  },
                  title: 'Calculadora XIPROFIT',
                ),
                _PreferenceButton(
                  title: 'Contactar',
                ),
                SizedBox(
                  height: 16,
                ),
                _PreferenceButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  title: 'Cerrar Sesión',
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future _showLogoutDialog(BuildContext currentContext) async {
    return showDialog(
        context: currentContext,
        builder: (context) {
          return AlertDialog(
            title: const Text("Cerrar sesion"),
            content: const Text("Desea cerrar sesion?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    currentContext
                        .read<PreferenceBloc>()
                        .add(PreferenceLogoutEvent());
                    Navigator.pop(context);
                  },
                  child: const Text("Si"))
            ],
          );
        });
  }
}

class _PreferenceButton extends StatelessWidget {
  final Function? onPressed;
  final String? title;

  const _PreferenceButton({
    Key? key,
    this.onPressed,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: onPressed != null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: MaterialButton(
          elevation: 0,
          color: Theme.of(context).primaryColorDark,
          disabledColor: Theme.of(context).primaryColorDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: this.onPressed as void Function()?,
          height: 88,
          minWidth: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    this.title!,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
