import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:ximena_hoyos_app/app/login/bloc/login_bloc.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/bloc.dart';
import 'package:ximena_hoyos_app/app/recipes/view/recipes_page.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

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
    bool isGoogle = true;
    Size size = MediaQuery.of(context).size;
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Column(
                  children: [
                    /*Image(
                      height: 40,
                      fit: BoxFit.fitHeight,
                      image: AssetImage('resources/app_logo.png'),
                    ),*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: size.width,
                          height: 400,
                          child: Image(
                            image: AssetImage('resources/ximena.webp'),
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Entrar con:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox( height: kDefaultPadding,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoginProviderButton(
                          buttonColor: Colors.white,
                          text: "Google",
                          textColor: Colors.black,
                          iconResourceName: "resources/google.png",
                          loginType: LoginType.google,
                          context: context,
                        ),
                        SizedBox( height: kDefaultPadding,),
                        LoginProviderButton(
                          buttonColor: Color(0xff3b5998),
                          text: "Facebook",
                          textColor: Colors.white,
                          iconResourceName: "resources/facebook.png",
                          loginType: LoginType.facebook,
                          context: context,
                        ),
                        SizedBox( height: kDefaultPadding,),
                        LoginProviderButton(
                          buttonColor: Colors.black,
                          text: "Apple",
                          textColor: Colors.white,
                          iconResourceName: "resources/apple.png",
                          loginType: LoginType.apple,
                          context: context,
                        ),
                      ],
                    )
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(kDefaultPadding),
                          height: 30,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'resources/facebook.png',
                              ),
                              fit: BoxFit.fitHeight
                            ),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent
                          ),
                        ),
                        SizedBox(width: kDefaultPadding),
                        LiteRollingSwitch(
                          value: isGoogle,
                          textOn: 'Google',
                          textOff: 'Facebook',
                          colorOn: Colors.lightGreen,
                          colorOff: Color(0xff3b5998),
                          iconOn: Icons.arrow_forward,
                          iconOff: Icons.arrow_back,
                          textSize: 14.0,
                          onChanged: (bool state) {
                            isGoogle = state;
                          },
                          onTap: (){

                          },
                          onDoubleTap: () {

                          },
                          onSwipe: (){

                          },
                        ),
                        SizedBox(width: kDefaultPadding),
                        Container(
                          padding: EdgeInsets.all(kDefaultPadding),
                          height: 35,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'resources/google_icon.png',
                              ),
                              fit: BoxFit.fitHeight
                            ),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding,),
                    TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                        ),
                        backgroundColor: MaterialStateProperty.all(Color(0xff92e600)),
                      ),
                      onPressed: () {
                        if(isGoogle == true){
                          context.read<LoginBloc>().add(LoginSubmitted(LoginType.google));
                        }
                        else{
                          context.read<LoginBloc>().add(LoginSubmitted(LoginType.facebook));
                        }
                      },
                      child: Text(
                        "Comenzar".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )
                      ),
                    ),*/
                  ],
                )
              ],
            )
          ]
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

class LoginProviderButton extends StatelessWidget {

  final Color? buttonColor;
  final String? text;
  final Color? textColor;
  final String? iconResourceName;
  final LoginType? loginType;
  final BuildContext context;

  const LoginProviderButton({
    Key? key,
    required this.buttonColor,
    required this.text,
    required this.textColor,
    required this.iconResourceName,
    required this.loginType,
    required this.context
  }) : super (key: key);

  @override
  Widget build(BuildContext context){
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )
        ),
        backgroundColor: MaterialStateProperty.all(this.buttonColor),
      ),
      onPressed: () {
        this.context.read<LoginBloc>().add(LoginSubmitted(this.loginType!));
      },
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                this.iconResourceName!
              ),
              height: 25,
              width: 25,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(width: 8,),
            Text(
              this.text!,
              style: TextStyle(
                fontSize: 14,
                color: this.textColor
              )
            ),
          ],
        ),
        height: 30,
        width: 200,
      )
    );
  }
}

