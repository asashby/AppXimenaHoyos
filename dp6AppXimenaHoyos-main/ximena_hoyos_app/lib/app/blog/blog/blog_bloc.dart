import 'package:data/models/tip_model.dart';
import 'package:data/repositories/tips_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State class

enum BlogStatus { initial, loading, success, error }

class BlogState extends Equatable {
  final List<Tip>? data;
  final int? page;
  final BlogStatus status;
  final Exception? exception;

  const BlogState._(this.status, {this.page, this.data, this.exception});

  const BlogState.initial() : this._(BlogStatus.initial);
  const BlogState.loading() : this._(BlogStatus.loading);
  const BlogState.success(List<Tip> data, int page)
      : this._(BlogStatus.success, data: data, page: page);
  const BlogState.error(Exception exception)
      : this._(BlogStatus.error, exception: exception);

  @override
  List<Object?> get props => [data, status, exception];
}

// Event class

abstract class BlogEvent extends Equatable {}

class FetchBlogsEvent extends BlogEvent {
  final bool refresh;

  FetchBlogsEvent({this.refresh = false});

  @override
  List<Object?> get props => [];
}

class FetchBlogDetailEvent extends BlogEvent {
  final Tip tipHeader;

  FetchBlogDetailEvent({required this.tipHeader});

  @override
  List<Object?> get props => [tipHeader];
}

// Bloc Class

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final TipsRepository repository;
  final List<Tip> data = [];
  var isFetching = false;
  var scrollPosition = 0.0;
  var page = 1;

  BlogBloc(this.repository) : super(BlogState.initial());

  @override
  Stream<BlogState> mapEventToState(BlogEvent event) async* {
    if (event is FetchBlogsEvent) {
      yield* mapFetchBlogEventToState(event);
    } else if (event is FetchBlogDetailEvent) {
      yield* mapFetchBlogDetailEventToState(event);
    }
  }

  Stream<BlogState> mapFetchBlogEventToState(FetchBlogsEvent event) async* {
    try {
      if (event.refresh) {
        page = 1;
      }

      yield BlogState.loading();
      final data = await repository.fetchTips(page);
      yield BlogState.success(data, page);
      page++;
    } on Exception catch (e) {
      yield BlogState.error(e);
    }
  }

  Stream<BlogState> mapFetchBlogDetailEventToState(
      FetchBlogDetailEvent event) async* {
    try {
      yield BlogState.loading();
      final data = await repository.fetchTipDetail(event.tipHeader.slug);
      if (data == null) {
        throw BlogNotFoundException();
      }
      yield BlogState.success([data], 0);
    } on Exception catch (e) {
      yield BlogState.error(e);
    }
  }
}

// Error Class

class BlogNotFoundException implements Exception {}
