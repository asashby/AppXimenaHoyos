import 'package:data/models/challenges_exercises_model.dart';
import 'package:data/models/exercise_model.dart';
import 'package:data/repositories/challenges_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/main.dart';

enum DailyRoutineStatus { initial, loading, success, error }

class DailyRoutineState extends Equatable {
  final DailyRoutineStatus status;
  final ExcerciseHeader? header;
  final List<Excercise>? exercises;
  final dynamic? error;

  const DailyRoutineState._(
      {required this.status, this.header, this.exercises, this.error});

  const DailyRoutineState.initial()
      : this._(status: DailyRoutineStatus.initial);

  const DailyRoutineState.loading()
      : this._(status: DailyRoutineStatus.loading);

  const DailyRoutineState.success(
      ExcerciseHeader header, List<Excercise> exercises)
      : this._(
            status: DailyRoutineStatus.success,
            header: header,
            exercises: exercises);

  const DailyRoutineState.error(dynamic error)
      : this._(status: DailyRoutineStatus.error, error: error);

  @override
  List<Object?> get props => [status, exercises, error];
}

class DailyRoutineEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoutineFetchEvent extends DailyRoutineEvent {
  final ChallengesDailyRoutine routine;

  RoutineFetchEvent(this.routine);

  @override
  List<Object?> get props => [routine];
}

class DailyRoutineBloc extends Bloc<DailyRoutineEvent, DailyRoutineState> {
  final ChallengesRepository repository;

  DailyRoutineBloc(this.repository) : super(DailyRoutineState.initial());

  @override
  Stream<DailyRoutineState> mapEventToState(DailyRoutineEvent event) async* {
    print(event);
    if (event is RoutineFetchEvent) {
      yield* _fetchRoutine(event.routine);
    }
  }

  Stream<DailyRoutineState> _fetchRoutine(
      ChallengesDailyRoutine routine) async* {
    try {
      yield DailyRoutineState.loading();
      final header =
          await repository.fetchDayExcersise(routine.slug, challengeSelectedId!);

      if (header == null || header.id == 0) {
        throw NoExerciseHeaderFoundException();
      }

      final exercises = await repository.fetchExcercisesRoutines(routine.id);

      yield DailyRoutineState.success(header, exercises);
    } on Exception catch (e) {
      yield DailyRoutineState.error(e);
    }
  }
}

class NoExerciseHeaderFoundException implements Exception {}
