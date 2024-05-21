import 'dart:async';

import 'package:barber/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
  }

  FutureOr<void> _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }
}
