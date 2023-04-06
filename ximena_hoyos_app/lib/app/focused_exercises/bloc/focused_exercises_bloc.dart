import 'package:data/models/challenge_detail.dart';
import 'package:data/models/challenge_plan.dart';
import 'package:data/models/focused_exercise.dart';
import 'package:data/repositories/focused_exercise_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FocusedExerciseBloc extends Bloc<FocusedExerciseEvent, FocusedExerciseState> {
  final FocusedExerciseRepository focusedExerciseRepository;

  FocusedExerciseBloc(
      this.focusedExerciseRepository,
      ): super(FocusedExerciseState.initial());

  @override
  Stream<FocusedExerciseState> mapEventToState(FocusedExerciseEvent event) async* {
    if (event is FocusedExerciseFetchEvent) {
      try {
        yield FocusedExerciseState.loading();
        final focusedExercisePlans = await focusedExerciseRepository.fetchFocusedExercisePlans();
        final focusedExercises = await focusedExerciseRepository.fetchFocusedExercises();
        final hasNotPayedExercises = focusedExercises.any((element) => element.currentUserIsSubscribed == false);
        final focusedChallengeDetail = new ChallengeDetail(
          subtitle: "Ximena Hoyos Pajares",
          title: "Avanzado en Gym 2.0",
          type: "Hipertrofia - Definición",
          slug: "",
          rating: 5,
          level: "Avanzado",
          frequency: "Diaria",
          days: focusedExercises.length,
          coursePaid: hasNotPayedExercises ? 0 : 1,
          description: "",
        );
        yield FocusedExerciseState.success(
          focusedChallengeDetail,
          focusedExercises,
          focusedExercisePlans,
        );
      } catch (ex){
        yield FocusedExerciseState.error(ex);
      }
    }
  }
}

enum FocusedExerciseStatus { initial, error, loading, success }
class FocusedExerciseState extends Equatable {
  final FocusedExerciseStatus status;
  final dynamic error;
  final ChallengeDetail? challengeDetail;
  final List<PlansByCourse>? focusedExercisePlans;
  final List<FocusedExercise>? focusedExercises;

  FocusedExerciseState(this.status, {
    this.error,
    this.challengeDetail,
    this.focusedExercisePlans,
    this.focusedExercises,
  });

  @override
  List<Object?> get props => [status, error, challengeDetail, focusedExercisePlans, focusedExercises] ;

  factory FocusedExerciseState.success(
      ChallengeDetail challengeDetail,
      List<FocusedExercise>? focusedExercises,
      List<PlansByCourse>? focusedExercisePlans,
      ) {
    return FocusedExerciseState(
      FocusedExerciseStatus.success,
      challengeDetail: challengeDetail,
      focusedExercises: focusedExercises,
      focusedExercisePlans: focusedExercisePlans,
    );
  }

  factory FocusedExerciseState.error(dynamic error) {
    return FocusedExerciseState(
        FocusedExerciseStatus.error,
        error: error
    );
  }

  factory FocusedExerciseState.loading() {
    return FocusedExerciseState(FocusedExerciseStatus.loading);
  }

  factory FocusedExerciseState.initial() {
    return FocusedExerciseState(FocusedExerciseStatus.initial);
  }
}

abstract class FocusedExerciseEvent {
}

class FocusedExerciseFetchEvent extends FocusedExerciseEvent {
}