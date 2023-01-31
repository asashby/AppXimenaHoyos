part of 'login_bloc.dart';

enum LoginType { facebook, google, apple }

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final LoginType loginType;

  const LoginSubmitted(this.loginType);
}
