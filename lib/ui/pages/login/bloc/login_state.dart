part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.state = PageState.none,
    this.email = '',
    this.password = '',
  });

  final PageState state;
  final String email;
  final String password;

  LoginState copyWith({
    PageState? state,
    String? email,
    String? password,
  }) {
    return LoginState(
      state: state ?? this.state,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [state, email, password];
}
