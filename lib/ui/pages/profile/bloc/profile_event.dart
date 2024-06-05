part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProfileNameChanged extends ProfileEvent {
  const ProfileNameChanged(this.name);

  final String name;
}

class ProfileCpfChanged extends ProfileEvent {
  const ProfileCpfChanged(this.cpf);

  final String cpf;
}

class ProfilePasswordChanged extends ProfileEvent {
  const ProfilePasswordChanged(this.password);

  final String password;
}

class ProfileSaveChanges extends ProfileEvent {}

class ProfileDeleteAccount extends ProfileEvent {}
