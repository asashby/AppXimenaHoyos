part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {
  LoginStateInitial() : super();
}

class LoginStateLoading extends LoginState {
  final LoginType loginType;
  LoginStateLoading(this.loginType) : super();
}

class LoginStateError extends LoginState {
  final Exception error;

  LoginStateError(this.error) : super();

  @override
  List<Object> get props => [error];
}
