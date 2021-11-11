import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:ximena_hoyos_app/app/login/bloc/login_bloc.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/bloc.dart';
import 'package:ximena_hoyos_app/app/recipes/view/recipes_page.dart';

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
            image: AssetImage('resources/new_background.webp'),
            fit: BoxFit.fitHeight,
            alignment: Alignment.topCenter,
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Image(
                  height: 40,
                  fit: BoxFit.fitHeight,
                  image: AssetImage('resources/app_logo.png'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AboutCard(),
                        RecipesCard()
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TrainingCard(),
                        TipsCard()
                      ],
                    )
                  ]
                ),
                /*Padding(
                  padding: EdgeInsets.all(20),
                  child: LiteRollingSwitch(
                    value: true,
                    textOn: "Google",
                    textOff: "Facebook",
                    colorOn: Colors.white,
                    colorOff: Color(0xff4867aa),
                    iconOn: Icons.face,
                    iconOff: Icons.access_alarm,
                    textSize: 20.0,
                  ),
                ),*/
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  //icon:FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  child: Text(
                    "Entrar con Google"
                  ),
                  onPressed: (){
                    context.read<LoginBloc>().add(LoginSubmitted(LoginType.google));
                  },
                ),
                ElevatedButton(
                  child: Text(
                    "Entrar con facebook"
                  ),
                  onPressed: (){
                    context.read<LoginBloc>().add(LoginSubmitted(LoginType.facebook));
                  },
                ),
              ],
            )
          ],
        ),
        //LoginForm()
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

class AboutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.0,
        height: 150.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'resources/OP01.jpg'),
                fit: BoxFit.cover)),
      );
  }
}

class TrainingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.0,
        height: 150.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'resources/OP02.jpg'),
                fit: BoxFit.cover)),
      );
  }
}


class RecipesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { 
          context.read<RecipeBloc>();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipesPage()),
          );
      },
      child: Container(
        width: 200.0,
        height: 150.0,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'resources/OP03.jpg'),
                fit: BoxFit.cover)),
      ),
    );
    /*return new GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipesPage()),
          );
        },
        child: new Container(
          width: 200.0,
          height: 150.0,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'resources/OP03.jpg'),
                  fit: BoxFit.cover)),
        ),
      )
    )*/
    /*return Container(
        width: 200.0,
        height: 150.0,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'resources/OP03.jpg'),
                fit: BoxFit.cover)),
      );*/
  }
}


class TipsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.0,
        height: 150.0,
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'resources/OP04.jpg'),
                fit: BoxFit.cover)),
      );
  }
}

