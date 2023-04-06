import 'package:data/models/challenges_exercises_model.dart';
import 'package:data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:data/models/challenge_detail.dart';
import 'package:data/models/challenge_plan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DetailStatus { initial, error, loading, success }

class DetailState extends Equatable {
  final ChallengeDetail? data;
  final List<PlansByCourse>? plans;
  final List<ChallengesDailyRoutine>? exercises;
  final dynamic error;
  final DetailStatus status;

  DetailState(
      this.status,
      {
        this.exercises,
        this.data,
        this.plans,
        this.error
      });

  @override
  List<Object?> get props => [data, error, status];

  factory DetailState.success(
    ChallengeDetail data,
    List<PlansByCourse>? plans, 
    List<ChallengesDailyRoutine> exercises) {
    return DetailState(
      DetailStatus.success, 
      data: data, 
      plans: plans,
      exercises: exercises
    );
  }

  factory DetailState.error(dynamic error) {
    return DetailState(DetailStatus.error, error: error);
  }

  factory DetailState.loading() {
    return DetailState(DetailStatus.loading);
  }

  factory DetailState.initial() {
    return DetailState(DetailStatus.initial);
  }
}

// Event Challenge Detail
class DetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailFetchEvent extends DetailEvent {
  final String slug;

  DetailFetchEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class ChallengeDetailBloc extends Bloc<DetailEvent, DetailState> {
  final ChallengesRepository repository;

  ChallengeDetailBloc(
      this.repository
      ) : super(DetailState.initial());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is DetailFetchEvent) {
      final slug = event.slug;

      try {
        yield DetailState.loading();
        final detail = await repository.fetchChallengeDetail(slug);
        final exercise = await repository.fetchRoutineByChallenge(slug);
        final plans = await repository.fetchChallengePlans(slug);
        exercise.sort((a, b) => a.day.compareTo(b.day));
        yield DetailState.success(
          detail, 
          plans.plansByCourse, 
          exercise
        );
      } catch (ex) {
        yield DetailState.error(ex);
      }
    }
  }
}
