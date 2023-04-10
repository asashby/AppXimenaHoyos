import 'package:data/models/challenges_exercises_model.dart';
import 'package:data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/components/challenge_attribute_view.dart';
import 'package:ximena_hoyos_app/app/daily_routine/bloc/daily_routine_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_page.dart';
import 'package:ximena_hoyos_app/app/routine/view/routine_page.dart';
import 'package:ximena_hoyos_app/common/item_exercise_card.dart';

class DailyRoutinePage extends StatelessWidget {
  final ChallengesDailyRoutine routine;
  final int? challengeId;

  const DailyRoutinePage({
    Key? key,
    required this.routine,
    required this.challengeId
  }) : super(key: key);

  static Route route(ChallengesDailyRoutine routine, int? challengeId) {
    return MaterialPageRoute<void>(
      builder: (_) => DailyRoutinePage(
        routine: routine,
        challengeId: challengeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => DailyRoutineBloc(RepositoryProvider.of(ctx)),
      child: BlocBuilder<DailyRoutineBloc, DailyRoutineState>(
          builder: (context, state) {
        switch (state.status) {
          case DailyRoutineStatus.initial:
            _start(context);
            return SizedBox.shrink();
          case DailyRoutineStatus.loading:
            return SizedBox(
              height: 400,
              child: Center(child: Center(child: CircularProgressIndicator())),
            );
          case DailyRoutineStatus.success:
            return _DailyRoutineContent(
              exerciseHeader: state.header!,
              exercises: state.exercises!,
              routine: routine,
            );
          case DailyRoutineStatus.error:
            print(state.error!);
            return Scaffold(
              backgroundColor: Colors.black,
              body: AppErrorView(
                exception: state.error!,
                onPressed: () {
                  _start(context);
                },
                onClose: () {
                  Navigator.of(context).pop();
                },
              ),
            );
        }
      }),
    );
  }

  _start(BuildContext context) {
    context.read<DailyRoutineBloc>().add(RoutineFetchEvent(routine));
  }
}

class _DailyRoutineContent extends StatelessWidget {
  final ExcerciseHeader exerciseHeader;
  final List<Excercise> exercises;
  final ChallengesDailyRoutine routine;

  const _DailyRoutineContent({
    Key? key,
    required this.exerciseHeader,
    required this.exercises,
    required this.routine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      onClosePressed: () {
        Navigator.of(context).pop();
      },
      slivers: [
        SliverToBoxAdapter(
          child: _DailyRoutineBody(
            header: exerciseHeader,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 60),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final exercise = exercises[index];
              return Container(
                color: Color(0xFF221b1c),
                padding: const EdgeInsets.only(
                    bottom: 12.0,
                    left: 28, right: 28
                ),
                child: ItemExerciseCard(
                  subtitle: "${exercise.serie.series} series - ${exercise.serie.repetitions} repeticiones",
                  title: exercise.title,
                  isCompleted: exercise.flagCompleted,
                  isAvailable: true,
                  defaultIcon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    // size: 48,
                  ),
                  iconBackgroundColor: Color(0xff95d100),
                  onPressed: () async {
                    final result = await Navigator.of(context)
                        .push(RoutinePage.route(exercises[index]));

                    if (result != null) {
                      context
                          .read<DailyRoutineBloc>()
                          .add(RoutineFetchEvent(routine));

                      _showMyDialog(context, exercises[index].title);
                    }
                  },
                ),
              );
            }, childCount: exercises.length),
          ),
        ),
      ],
      backgroundColor: Color(0xFF221b1c),
      imageNetwork: exerciseHeader.mobileImage,
    );
  }

  Future<void> _showMyDialog(BuildContext context, String routineName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Felicitaciones'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Ha terminado con la rutina de $routineName"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Entendido'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _DailyRoutineBody extends StatelessWidget {
  final ExcerciseHeader header;

  const _DailyRoutineBody({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF221b1c),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
          )
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Text(
            header.subtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            header.title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(
            height: 36,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            margin: const EdgeInsets.only(right: 32, left: 32),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: ChallengeAttributeView(
                    title: 'Duración',
                    value: header.duration,
                  ),
                ),
                Expanded(
                  child: ChallengeAttributeView(
                    title: 'Tiempo de reposo',
                    value: header.restTime,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}