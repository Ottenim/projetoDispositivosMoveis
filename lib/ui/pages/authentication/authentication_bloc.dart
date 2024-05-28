import 'dart:async';

import 'package:barber/repositories/user_repository.dart';
import 'package:barber/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.userRepository) : super(const AuthenticationState()) {
    _authStream.listen((value) => add(AuthenticationStateChanged(value)));

    on<AuthenticationInitialValidation>(_onInitialValidation);
    on<AuthenticationStateChanged>(_onStateChanged);
  }

  final UserRepository userRepository;

  StreamController<AuthenticationUser> authController = StreamController();

  Stream<AuthenticationUser> get _authStream async* {
    yield* authController.stream;
  }

  FutureOr<void> _onInitialValidation(
    AuthenticationInitialValidation event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading()));

    await Future.delayed(Duration(seconds: 2));

    try {
      String? jsonUser = await Prefs.getString(PrefsKeys.userProperty);

      if (jsonUser != null) {
        await userRepository.setUser(jsonUser);

        authController.add(AuthenticationUser.authenticated);
      }
    } catch (e) {
      authController.add(AuthenticationUser.unauthenticated);

      emit(state.copyWith(state: PageState.error()));
    }

    authController.add(AuthenticationUser.unauthenticated);
  }

  FutureOr<void> _onStateChanged(
    AuthenticationStateChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(authenticationUser: event.value));
  }

  @override
  Future<void> close() async {
    await authController.close();

    await super.close();
  }
}
