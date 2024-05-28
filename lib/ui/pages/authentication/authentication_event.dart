part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthenticationInitialValidation extends AuthenticationEvent {}

class AuthenticationStateChanged extends AuthenticationEvent {
  const AuthenticationStateChanged(this.value);

  final AuthenticationUser value;
}
