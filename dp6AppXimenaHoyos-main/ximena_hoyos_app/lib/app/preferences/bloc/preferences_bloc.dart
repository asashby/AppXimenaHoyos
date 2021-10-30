import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Preference Logout State

class PreferenceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PreferenceStateInitial extends PreferenceState {}

class PreferenceStateLoading extends PreferenceState {}

class PreferenceStateError extends PreferenceState {
  final Exception error;

  PreferenceStateError(this.error) : super();

  @override
  List<Object?> get props => [this.error];
}

class PreferenceStateSuccess extends PreferenceState {}

// Preference Logout Event

class PreferenceEvent {}

class PreferenceLogoutEvent extends PreferenceEvent {}

// Preference Bloc

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  final AuthenticationDataSource authenticationDataSource;

  PreferenceBloc(this.authenticationDataSource)
      : super(PreferenceStateInitial());

  @override
  Stream<PreferenceState> mapEventToState(PreferenceEvent event) async* {
    if (event is PreferenceLogoutEvent) {
      yield PreferenceStateLoading();

      try {
        await authenticationDataSource.logOut();

        var accessToken = await FacebookAuth.instance.accessToken;

        if (accessToken != null && !accessToken.isExpired) {
          FacebookAuth.instance.logOut();
        }

        yield PreferenceStateSuccess();
      } on Exception catch (ex) {
        yield PreferenceStateError(ex);
      }
    }
  }
}
