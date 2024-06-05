part of 'authentication_bloc.dart';

enum AuthenticationUser { none, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.authenticationUser,
    this.state = const PageState(PageStatus.none),
  });

  final AuthenticationUser? authenticationUser;
  final PageState state;

  AuthenticationState copyWith({
    AuthenticationUser? authenticationUser,
    PageState? state,
  }) {
    return AuthenticationState(
      state: state ?? this.state,
      authenticationUser: authenticationUser ?? this.authenticationUser,
    );
  }

  @override
  List<Object?> get props => [state, authenticationUser];
}
