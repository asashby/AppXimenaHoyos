// States Challenge Detail

import 'package:data/models/challenges_exercises_model.dart';
import 'package:data/repositories/repositories.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:data/models/challenge_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DetailStatus { initial, error, loading, success }

class DetailState extends Equatable {
  final ChallengeDetail? data;
  final List<ChallengesDailyRoutine>? exercises;
  final dynamic error;
  final DetailStatus status;

  DetailState(this.status, {this.exercises, this.data, this.error});

  @override
  List<Object?> get props => [data, error, status];

  factory DetailState.success(
      ChallengeDetail data, List<ChallengesDailyRoutine> exercises) {
    return DetailState(DetailStatus.success, data: data, exercises: exercises);
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

// Bloc Challenge Detail

class ChallengeDetailBloc extends Bloc<DetailEvent, DetailState> {
  final ChallengesRepository repository;
  final CompanyRepository companyRepository;
  final AuthenticationDataSource authRepository;

  ChallengeDetailBloc(
      this.repository, this.companyRepository, this.authRepository)
      : super(DetailState.initial());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is DetailFetchEvent) {
      final slug = event.slug;

      try {
        yield DetailState.loading();
        final detail = await repository.fetchChallengeDetail(slug);
        final exercise = await repository.fetchRoutineByChallenge(slug);
        exercise.sort((a, b) => a.day.compareTo(b.day));
        yield DetailState.success(detail, exercise);
      } catch (ex) {
        yield DetailState.error(ex);
      }
    }
  }

  Future<String> generateOrderLink() async {
    final company = await companyRepository.getCompanyInfo();
    final profile = await authRepository.user;
    final detail = state.data;

    final preOrder =
        await repository.createPreOrder(company!, detail!, profile!);

    try {
      await repository.createChallengeRegister(preOrder, detail.slug!);
    } on Exception catch (e) {
      if (e is DioError && e.response?.statusCode == 400) {
        print('Ya registrado');
      } else {
        throw e;
      }
    }

    return preOrder.processUrl;
  }
}
