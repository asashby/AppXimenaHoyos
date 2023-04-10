import 'package:data/models/focused_exercise.dart';
import 'package:data/repositories/focused_exercise_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FocusedExerciseItemsBloc extends Bloc<FocusedExerciseItemsEvent, FocusedExerciseItemsState> {
  final FocusedExerciseRepository focusedExerciseRepository;

  FocusedExerciseItemsBloc(
      this.focusedExerciseRepository,
      ): super(FocusedExerciseItemsState.initial());

  @override
  Stream<FocusedExerciseItemsState> mapEventToState(FocusedExerciseItemsEvent event) async* {
    if (event is FocusedExerciseItemsFetchEvent) {
      try {
        yield FocusedExerciseItemsState.loading();
        final focusedExercise = await focusedExerciseRepository.fetchFocusedExerciseById(event.focusedExerciseId);
        yield FocusedExerciseItemsState.success(
          focusedExercise,
        );
      } catch (ex){
        yield FocusedExerciseItemsState.error(ex);
      }
    }
  }
}

enum FocusedExerciseItemsStatus { initial, error, loading, success }
class FocusedExerciseItemsState extends Equatable {
  final FocusedExerciseItemsStatus status;
  final dynamic error;
  final FocusedExercise? focusedExercise;

  FocusedExerciseItemsState(this.status, {
    this.error,
    this.focusedExercise
  });

  @override
  List<Object?> get props => [status, error, focusedExercise] ;

  factory FocusedExerciseItemsState.success(
      FocusedExercise? focusedExercise,
      ) {
    return FocusedExerciseItemsState(
      FocusedExerciseItemsStatus.success,
      focusedExercise: focusedExercise,
    );
  }

  factory FocusedExerciseItemsState.error(dynamic error) {
    return FocusedExerciseItemsState(
        FocusedExerciseItemsStatus.error,
        error: error
    );
  }

  factory FocusedExerciseItemsState.loading() {
    return FocusedExerciseItemsState(FocusedExerciseItemsStatus.loading);
  }

  factory FocusedExerciseItemsState.initial() {
    return FocusedExerciseItemsState(FocusedExerciseItemsStatus.initial);
  }
}

class FocusedExerciseItemsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FocusedExerciseItemsFetchEvent extends FocusedExerciseItemsEvent {
  final int focusedExerciseId;

  FocusedExerciseItemsFetchEvent(this.focusedExerciseId);

  @override
  List<Object?> get props => [focusedExerciseId];
}