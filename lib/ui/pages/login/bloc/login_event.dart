part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginCpfChanged extends LoginEvent {
  const LoginCpfChanged(this.cpf);

  final String cpf;
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;
}

class LoginContinuePressed extends LoginEvent {}
