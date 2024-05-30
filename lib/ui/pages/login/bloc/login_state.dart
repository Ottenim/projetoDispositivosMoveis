part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.state = const PageState(PageStatus.none),
    this.cpf = '',
    this.password = '',
  });

  final PageState state;
  final String cpf;
  final String password;

  LoginState copyWith({
    PageState? state,
    String? cpf,
    String? password,
  }) {
    return LoginState(
      state: state ?? this.state,
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [state, cpf, password];
}
