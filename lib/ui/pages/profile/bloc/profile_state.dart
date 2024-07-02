part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.name = '',
    this.cpf = '',
    this.newPassword = '',
    this.imagePath = '',
    this.state = const PageState(PageStatus.none),
  });

  final String name;
  final String cpf;
  final String newPassword;
  final String imagePath;
  final PageState state;

  ProfileState copyWith({
    String? name,
    String? cpf,
    String? newPassword,
    String? imagePath,
    PageState? state,
  }) {
    return ProfileState(
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      newPassword: newPassword ?? this.newPassword,
      imagePath: imagePath ?? this.imagePath,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [name, cpf, newPassword, imagePath, state];
}
