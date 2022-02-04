import 'package:flutter/material.dart';

class RecipesBlockedView extends StatelessWidget {
  const RecipesBlockedView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'resources/lock.png',
          fit: BoxFit.fitHeight,
          height: 200,
        ),
        Text(
          'Contenido bloqueado',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Necesitas desbloquear un entrenamiento para poder ver las recetas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        )
      ]
    );
  }
}