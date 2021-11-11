// State class
import 'package:data/models/comment_model.dart';
import 'package:data/repositories/challenges_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CommentStatus { initial, loading, success, error }

class CommentState extends Equatable {
  final List<Comment>? data;
  final CommentStatus status;
  final Exception? exception;

  const CommentState._(this.status, {this.data, this.exception});

  const CommentState.initial() : this._(CommentStatus.initial);
  const CommentState.loading() : this._(CommentStatus.loading);
  const CommentState.success(List<Comment> data)
      : this._(CommentStatus.success, data: data);
  const CommentState.error(Exception exception)
      : this._(CommentStatus.error, exception: exception);

  @override
  List<Object?> get props => [data, status, exception];
}

// Event class

abstract class CommentEvent extends Equatable {}

class FetchCommentEvent extends CommentEvent {
  final String challengeSlug;

  FetchCommentEvent(this.challengeSlug);

  @override
  List<Object?> get props => [];
}

// Bloc Class

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ChallengesRepository repository;

  CommentBloc(this.repository) : super(CommentState.initial());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is FetchCommentEvent) {
      yield CommentState.loading();
      try {
        final comments = await repository.fetchComments(event.challengeSlug);

        if (comments.isEmpty) {
          throw CommentsNotFoundException();
        }

        yield CommentState.success(comments);
      } on Exception catch (e) {
        yield CommentState.error(e);
      }
    }
  }
}

class CommentsNotFoundException implements Exception {}
