import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:data/data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationDataSource repository;
  late StreamSubscription<bool> _authenticationSubscription;

  AuthenticationBloc(this.repository) : super(AuthenticationState.unknown()) {
    _authenticationSubscription = repository.isLogged.listen((event) {
      add(AuthenticationUserChanged(event
          ? AuthenticationStatus.authenticated
          : AuthenticationStatus.unauthenticated));
    });
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield await _mapAuthenticationStatusChangeToState(event);
    } else if (event is AuthenticationLogoutRequest) {
      repository.logOut();
      add(AuthenticationUserChanged(AuthenticationStatus.unauthenticated));
    }
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangeToState(
      AuthenticationUserChanged event) async {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        return const AuthenticationState.authenticate("ABSSDASDSAD");
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  @override
  Future<void> close() {
    repository.dispose();
    _authenticationSubscription.cancel();
    return super.close();
  }
}
