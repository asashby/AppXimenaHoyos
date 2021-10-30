// Events
import 'package:data/models/challenge_detail.dart';
import 'package:data/repositories/challenges_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CommentEvent extends Equatable {}

class PostCommentEvent extends CommentEvent {
  final String title;
  final String comment;
  final double rating;
  final ChallengeDetail detail;

  PostCommentEvent(
      {required this.title,
      required this.comment,
      required this.rating,
      required this.detail});

  @override
  List<Object?> get props => [title, comment, rating, detail];
}

// States

enum CommentChallengeStatus { initial, loading, error, success }

class CommentChallengeState extends Equatable {
  final CommentChallengeStatus status;
  final Exception? error;

  CommentChallengeState(this.status, {this.error});

  @override
  List<Object?> get props => [status, error];

  factory CommentChallengeState.success() {
    return CommentChallengeState(CommentChallengeStatus.success);
  }

  factory CommentChallengeState.error(dynamic error) {
    return CommentChallengeState(CommentChallengeStatus.error, error: error);
  }

  factory CommentChallengeState.loading() {
    return CommentChallengeState(CommentChallengeStatus.loading);
  }

  factory CommentChallengeState.initial() {
    return CommentChallengeState(CommentChallengeStatus.initial);
  }
}

// Bloc

class CommentChallengeBloc extends Bloc<CommentEvent, CommentChallengeState> {
  final ChallengesRepository repository;

  CommentChallengeBloc({required this.repository})
      : super(CommentChallengeState.initial());

  @override
  Stream<CommentChallengeState> mapEventToState(CommentEvent event) async* {
    print('object');
    if (event is PostCommentEvent) {
      try {
        // if (event.title.isEmpty) {
        //   throw TitleEmptyException();
        // }

        if (event.comment.isEmpty) {
          throw CommentEmptyException();
        }

        if (event.rating < 1) {
          throw RatingRequireException();
        }

        yield CommentChallengeState.loading();
        await repository.postComment(
            challengeSlug: event.detail.slug!,
            rating: event.rating,
            title: event.title,
            content: event.comment);
        yield CommentChallengeState.success();
      } on Exception catch (e) {
        yield CommentChallengeState.error(e);
      }
    }
  }
}

class TitleEmptyException implements Exception {}

class CommentEmptyException implements Exception {}

class RatingRequireException implements Exception {}
