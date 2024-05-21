part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;
}
