import 'package:data/models/challenge_header_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChallengeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChallengeInitialState extends ChallengeState {}

class ChallengeLoadingState extends ChallengeState {}

class ChallengeSuccessState extends ChallengeState {
  final List<ChallengeHeader> challenges;
  final bool cleanData;

  ChallengeSuccessState(this.challenges, this.cleanData);

  @override
  List<Object> get props => [challenges];
}

class ChallengeErrorState extends ChallengeState {
  final Exception error;

  ChallengeErrorState(this.error);

  @override
  List<Object> get props => [error];
}
