import 'package:data/repositories/challenges_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:data/models/exercise_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RoutineStatus { initial, loading, success, error }

class RoutineState extends Equatable {
  final RoutineStatus state;
  final ExerciseDetail? data;
  final Exception? error;

  RoutineState._({this.state = RoutineStatus.initial, this.data, this.error});

  @override
  List<Object?> get props => [state, data, error];

  RoutineState.initial() : this._();
  RoutineState.loading() : this._(state: RoutineStatus.loading);
  RoutineState.error(Exception error)
      : this._(state: RoutineStatus.error, error: error);
  RoutineState.success(ExerciseDetail data)
      : this._(state: RoutineStatus.success, data: data);
}

abstract class RoutineEvent extends Equatable {}

class FetchRoutienEvent extends RoutineEvent {
  final Excercise exercise;

  FetchRoutienEvent(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

class FinishSerieEvent extends RoutineEvent {
  final int unitId;
  final int questionId;
  final int setNumber;
  final ExerciseDetail data;

  FinishSerieEvent(this.unitId, this.questionId, this.setNumber, this.data);

  @override
  List<Object?> get props => [unitId, questionId, setNumber, data];
}

// BLOC

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final ChallengesRepository repository;
  bool isCompleted = false;
  bool isResting = false;

  RoutineBloc(this.repository) : super(RoutineState.initial());

  @override
  Stream<RoutineState> mapEventToState(RoutineEvent event) async* {
    if (event is FetchRoutienEvent) {
      yield* mapFetchEvent(event);
    } else if (event is FinishSerieEvent) {
      yield* mapFinishSetEvent(event);
    }
  }

  Stream<RoutineState> mapFetchEvent(FetchRoutienEvent event) async* {
    try {
      yield RoutineState.loading();

      final response = await repository.fetchRoutine(event.exercise);

      if (response == null) {
        throw RoutineNotFoundException();
      }

      yield RoutineState.success(response);
    } on Exception catch (e) {
      yield RoutineState.error(e);
    }
  }

  Stream<RoutineState> mapFinishSetEvent(FinishSerieEvent event) async* {
    try {
      await repository.finishSet(
          event.unitId, event.questionId, event.setNumber);

      final data = event.data.copyWith(
          series: event.data.series.map((e) {
        if (e.serie == event.setNumber) {
          return e.copyWith(flagComplete: true);
        }
        return e;
      }).toList());

      this.isCompleted =
          data.series.where((element) => !element.flagComplete).isEmpty;

      yield RoutineState.success(data);
    } on Exception catch (e) {
      yield RoutineState.error(e);
    }
  }
}

class RoutineNotFoundException implements Exception {}
