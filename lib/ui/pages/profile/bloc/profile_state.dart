part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.name = '',
    this.cpf = '',
    this.newPassword = '',
    this.state = const PageState(PageStatus.none),
  });

  final String name;
  final String cpf;
  final String newPassword;
  final PageState state;

  ProfileState copyWith({
    String? name,
    String? cpf,
    String? newPassword,
    PageState? state,
  }) {
    return ProfileState(
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      newPassword: newPassword ?? this.newPassword,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [name, cpf, newPassword, state];
}
