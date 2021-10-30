import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/login/bloc/login_bloc.dart';

import 'login_launcher.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) => LoginBloc(RepositoryProvider.of(context)),
          child: LoginView()),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage('resources/app_background.webp'),
            fit: BoxFit.fitHeight,
            alignment: Alignment.topCenter,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
            child: Image(
              height: 60,
              fit: BoxFit.fitHeight,
              image: AssetImage('resources/app_logo.png'),
            ),
          ),
        ),
        LoginForm()
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Text(
                "Ingresa con",
                style: Theme.of(context).textTheme.headline2,
              ),
              LoginLauncher(),
              Visibility(
                visible: false,
                child: Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Terminos y condiciones",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
