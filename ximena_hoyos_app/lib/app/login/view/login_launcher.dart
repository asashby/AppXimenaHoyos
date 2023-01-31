import 'package:data/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/login/bloc/bloc.dart';

class LoginLauncher extends StatefulWidget {
  const LoginLauncher({
    Key? key,
  }) : super(key: key);

  @override
  _LoginLauncherState createState() => _LoginLauncherState();
}

class _LoginLauncherState extends State<LoginLauncher> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        listener: _onListenerConsumer, builder: _buildBody);
  }

  _onListenerConsumer(BuildContext context, LoginState state) {
    if (state is LoginStateError) {
      final String message;

      final exception = state.error;

      if (exception is HttpErrorException) {
        message = exception.message;
      } else {
        message = exception.toString();
      }

      final snackbar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Widget _buildBody(BuildContext context, LoginState state) {
    if (state is LoginStateLoading) {
      return Container(
        width: 270,
        height: 70,
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          decoration: BoxDecoration(
              color: state.loginType == LoginType.facebook
                  ? Color(0xFF0076fc)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Container(
      width: 270,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          LoginButton(
            color: Color(0xFF0076fc),
            onPressed: () => {
              context.read<LoginBloc>().add(LoginSubmitted(LoginType.facebook))
            },
            iconName: 'resources/facebook.png',
            text: "Ingresar con Facebook",
            textColor: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          LoginButton(
            color: Colors.white,
            onPressed: () => {
              context.read<LoginBloc>().add(LoginSubmitted(LoginType.google))
            },
            iconName: 'resources/google.png',
            text: "Ingresar con Google",
            textColor: Colors.grey[500],
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function? onPressed;
  final Color? color;
  final String? iconName;
  final String? text;
  final Color? textColor;

  const LoginButton({
    Key? key,
    this.onPressed,
    this.color,
    this.iconName,
    this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 70,
      color: this.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: this.onPressed as void Function()?,
      child: Row(
        children: [
          SizedBox(
            child: Image.asset(
              iconName!,
              fit: BoxFit.fitHeight,
            ),
            height: 20,
            width: 35,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text!,
            style: TextStyle(color: textColor, fontSize: 16),
          )
        ],
      ),
    );
  }
}
