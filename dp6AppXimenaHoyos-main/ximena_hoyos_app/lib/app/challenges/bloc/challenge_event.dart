import 'package:equatable/equatable.dart';

abstract class ChallengeEvent extends Equatable {
  const ChallengeEvent();

  @override
  List<Object?> get props => [];
}

class ChallengeFetchEvent extends ChallengeEvent {
  final int sectionId;

  ChallengeFetchEvent(this.sectionId);

  @override
  List<Object?> get props => [sectionId];
}

class ChallengeRefreshEvent extends ChallengeEvent {
  final int sectionId;

  ChallengeRefreshEvent(this.sectionId);

  @override
  List<Object?> get props => [sectionId];
}
