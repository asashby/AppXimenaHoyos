import 'package:data/models/focused_exercise_item.dart';
import 'package:data/repositories/focused_exercise_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FocusedExerciseItemBloc extends Bloc<FocusedExerciseItemEvent, FocusedExerciseItemState> {
  final FocusedExerciseRepository focusedExerciseRepository;

  FocusedExerciseItemBloc(
      this.focusedExerciseRepository,
      ): super(FocusedExerciseItemState.initial());

  @override
  Stream<FocusedExerciseItemState> mapEventToState(FocusedExerciseItemEvent event) async* {
    if (event is FocusedExerciseItemFetchEvent) {
      try {
        yield FocusedExerciseItemState.loading();
        // TODO Maybe implement request by focused exercise item primary key
        yield FocusedExerciseItemState.success(
          event.focusedExerciseItem,
        );
      } catch (ex){
        yield FocusedExerciseItemState.error(ex);
      }
    }
  }
}

enum FocusedExerciseItemStatus { initial, error, loading, success }
class FocusedExerciseItemState extends Equatable {
  final FocusedExerciseItemStatus status;
  final dynamic error;
  final FocusedExerciseItem? focusedExerciseItem;

  FocusedExerciseItemState(this.status, {
    this.error,
    this.focusedExerciseItem
  });

  @override
  List<Object?> get props => [status, error, focusedExerciseItem] ;

  factory FocusedExerciseItemState.success(
      FocusedExerciseItem? focusedExerciseItem,
      ) {
    return FocusedExerciseItemState(
      FocusedExerciseItemStatus.success,
      focusedExerciseItem: focusedExerciseItem,
    );
  }

  factory FocusedExerciseItemState.error(dynamic error) {
    return FocusedExerciseItemState(
        FocusedExerciseItemStatus.error,
        error: error
    );
  }

  factory FocusedExerciseItemState.loading() {
    return FocusedExerciseItemState(FocusedExerciseItemStatus.loading);
  }

  factory FocusedExerciseItemState.initial() {
    return FocusedExerciseItemState(FocusedExerciseItemStatus.initial);
  }
}

class FocusedExerciseItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FocusedExerciseItemFetchEvent extends FocusedExerciseItemEvent {
  final FocusedExerciseItem focusedExerciseItem;

  FocusedExerciseItemFetchEvent(this.focusedExerciseItem);

  @override
  List<Object?> get props => [focusedExerciseItem];
}