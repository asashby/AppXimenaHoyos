import 'package:data/models/about_model.dart';
import 'package:data/repositories/tips_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State class

enum AboutStatus { initial, loading, success, error }

class AboutState extends Equatable {
  final About? data;
  final AboutStatus status;
  final Exception? exception;

  const AboutState._(this.status, {this.data, this.exception});

  const AboutState.initial() : this._(AboutStatus.initial);
  const AboutState.loading() : this._(AboutStatus.loading);
  const AboutState.success(About data)
      : this._(AboutStatus.success, data: data);
  const AboutState.error(Exception exception)
      : this._(AboutStatus.error, exception: exception);

  @override
  List<Object?> get props => [data, status, exception];
}

// Event class

abstract class AboutEvent extends Equatable {}

class FetchAboutEvent extends AboutEvent {
  FetchAboutEvent();

  @override
  List<Object?> get props => [];
}

// Bloc Class

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final TipsRepository repository;

  AboutBloc(this.repository) : super(AboutState.initial());

  @override
  Stream<AboutState> mapEventToState(AboutEvent event) async* {
    if (event is FetchAboutEvent) {
      yield AboutState.loading();
      try {
        final about = await repository.fetchAbout();

        if (about == null) {
          throw AboutNotFoundException();
        }

        yield AboutState.success(about);
      } on Exception catch (e) {
        yield AboutState.error(e);
      }
    }
  }
}

class AboutNotFoundException implements Exception {}
