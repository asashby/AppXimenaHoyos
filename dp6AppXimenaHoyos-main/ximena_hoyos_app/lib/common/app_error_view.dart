import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/commentaries/bloc/commentaries_bloc.dart';
import 'package:ximena_hoyos_app/app/daily_routine/bloc/daily_routine_bloc.dart';
import 'package:ximena_hoyos_app/app/routine/bloc/routine_bloc.dart';

import 'app_button.dart';

class AppErrorView extends StatelessWidget {
  final Function onPressed;
  final VoidCallback? onClose;
  final double height;
  final String? message;
  final Exception? exception;

  final defaultMessage = 'Ha ocurrido un error inesperado, intente nuevamente';

  const AppErrorView({
    Key? key,
    required this.onPressed,
    this.height = double.infinity,
    this.message,
    this.exception,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: this.height,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: onClose != null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 130,
                    child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        fillColor: Theme.of(context).primaryColorDark,
                        onPressed: this.onClose,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Regresar',
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
            Text(
              _createExceptionMessageError(exception) ??
                  message ??
                  defaultMessage,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 175,
              height: 45,
              child: AppButton(title: 'Reintentar', onPressed: this.onPressed),
            ),
          ],
        ),
      ),
    );
  }

  String? _createExceptionMessageError(Exception? exception) {
    if (exception == null) {
      return null;
    }

    if (exception is NoExerciseHeaderFoundException) {
      return 'No se encontro la cabecera del ejercicio, contactar con el proveedor del servicio';
    } else if (exception is DioError) {
      return 'Ocurrio un error inesperado (${exception.response?.statusCode ?? 0})';
    } else if (exception is RoutineNotFoundException) {
      return 'No se encontro la rutina de entrenamiento';
    } else if (exception is CommentsNotFoundException) {
      return 'No se encontraron comentarios';
    } else {
      return defaultMessage;
    }
  }
}
