part of 'user_register_bloc.dart';

class UserRegisterState extends Equatable {
  const UserRegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.state = const PageState(PageStatus.none),
  });

  final String name;
  final String email;
  final String password;
  final PageState state;

  UserRegisterState copyWith({
    String? name,
    String? email,
    String? password,
    PageState? state,
  }) {
    return UserRegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [name, email, password, state];
}
