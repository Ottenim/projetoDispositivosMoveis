import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/repositories/repositories.dart';
import 'package:barber/services/services.dart';
import 'package:barber/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.userRepository) : super(LoginState()) {
    on<LoginCpfChanged>(_onCpfChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginContinuePressed>(_onContinuePressed);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final UserRepository userRepository;
  final UserService userService = UserService();

  FutureOr<void> _onCpfChanged(
    LoginCpfChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(cpf: event.cpf));
  }

  FutureOr<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onContinuePressed(
    LoginContinuePressed event,
    Emitter<LoginState> emit,
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(state: PageState.loading('Acessando app')));

      try {
        User? user = await userService.getUserByCpf(state.cpf);

        if (user == null) {
          emit(state.copyWith(state: PageState.error('Usuário inexistente')));
        } else if (user.password == state.password) {
          await userRepository.setUser(user.id ?? '', user.toMap());

          emit(state.copyWith(state: PageState.success(data: user)));
        } else {
          emit(state.copyWith(state: PageState.error('cpf ou senha incorretos')));
        }
      } catch (e) {
        emit(state.copyWith(state: PageState.error('Houve um erro ao realizar o login, verifique seus dados')));
      }
    } else {
      emit(state.copyWith(state: PageState.error('Dados incorretor, verifique novamente')));
    }
  }
}
