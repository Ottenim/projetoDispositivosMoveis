part of 'user_register_bloc.dart';

class UserRegisterState extends Equatable {
  const UserRegisterState({
    this.name = '',
    this.cpf = '',
    this.password = '',
    this.state = const PageState(PageStatus.none),
  });

  final String name;
  final String cpf;
  final String password;
  final PageState state;

  UserRegisterState copyWith({
    String? name,
    String? cpf,
    String? password,
    PageState? state,
  }) {
    return UserRegisterState(
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [name, cpf, password, state];
}
