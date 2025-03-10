part of 'user_register_bloc.dart';

class UserRegisterEvent extends Equatable {
  const UserRegisterEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserRegisterNameChanged extends UserRegisterEvent {
  const UserRegisterNameChanged(this.name);

  final String name;
}

class UserRegisterCpfChanged extends UserRegisterEvent {
  const UserRegisterCpfChanged(this.cpf);

  final String cpf;
}

class UserRegisterPasswordChanged extends UserRegisterEvent {
  const UserRegisterPasswordChanged(this.password);

  final String password;
}

class UserRegisterCreate extends UserRegisterEvent {}
