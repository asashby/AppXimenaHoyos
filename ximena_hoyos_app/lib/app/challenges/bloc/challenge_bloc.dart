import 'package:data/data.dart';
import 'package:data/models/challenge_header_model.dart';
import 'package:data/repositories/challenges_repository.dart';
import 'package:data/repositories/focused_exercise_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/challenges/bloc/challenge_event.dart';
import 'package:ximena_hoyos_app/app/challenges/bloc/challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  final ChallengesRepository repository;
  final AuthenticationDataSource authenticationRepository;
  final FocusedExerciseRepository focusedExerciseRepository;

  int currentPage = 1;
  bool isFetching = false;

  ChallengeBloc(
      {
        required this.repository,
        required this.authenticationRepository,
        required this.focusedExerciseRepository,
      })
      : super(ChallengeInitialState());

  @override
  Stream<ChallengeState> mapEventToState(ChallengeEvent event) async* {
    print(event);
    if (event is ChallengeFetchEvent) {
      yield* mapFetchEventToState(event);
    } else if (event is ChallengeRefreshEvent) {
      yield* mapFetchRefreshEventToState(event);
    }
  }

  Stream<ChallengeState> mapFetchEventToState(
      ChallengeFetchEvent event) async* {
    try {
      yield ChallengeLoadingState();

      List<ChallengeHeader> challenges;
      var focusedExerciseHeader = new ChallengeHeader(
        id: 0,
        title: "Avanzado en Gym 2.0",
        urlImage: "https://cms.ximehoyosfit.com//storage/mobile_image/ysQjjneE5PiRthNLq83793PXC2UggM9R5C1FJxxO.jpg",
        days: 5,
        level: "Avanzada",
        slug: "avanzado-gym-20",
        frequency: "Diario",
      );
      if (event.sectionId == 0) {
        var user = await authenticationRepository.user;
        if (user != null) {
          challenges = await repository.fetchChallengesByUser(user.id!, currentPage);
          bool isSubscribedToFocused = await focusedExerciseRepository.getCurrentUserIsSubscribed();
          if (isSubscribedToFocused) {
            challenges.add(focusedExerciseHeader);
          }
        } else {
          challenges = [];
        }
      } else {
        challenges = await repository.fetchChallenges(currentPage);
        challenges.add(focusedExerciseHeader);
      }

      yield ChallengeSuccessState(challenges, currentPage == 1);
      currentPage++;
    } on Exception catch (e) {
      yield ChallengeErrorState(e);
    }
  }

  Stream<ChallengeState> mapFetchRefreshEventToState(
      ChallengeRefreshEvent event) {
    currentPage = 1;
    return mapFetchEventToState(ChallengeFetchEvent(event.sectionId));
  }
}
