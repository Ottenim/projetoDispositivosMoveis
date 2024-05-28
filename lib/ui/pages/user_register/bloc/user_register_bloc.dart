import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_register_event.dart';

part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  UserRegisterBloc() : super(const UserRegisterState()) {
    on<UserRegisterNameChanged>(_onNameChanged);
    on<UserRegisterEmailChanged>(_onEmailChanged);
    on<UserRegisterPasswordChanged>(_onPasswordChanged);
    on<UserRegisterCreate>(_onCreate);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FutureOr<void> _onNameChanged(
    UserRegisterNameChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onEmailChanged(
    UserRegisterEmailChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onPasswordChanged(
    UserRegisterPasswordChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onCreate(
    UserRegisterCreate event,
    Emitter<UserRegisterState> emit,
  ) {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(state: PageState.loading('Criando usuário')));

      try {
        // REGRA PARA INSERIR O USUÁRIO

        emit(state.copyWith(state: PageState.success(info: 'Usuário criado', data: User())));
      } catch (e) {
        emit(state.copyWith(state: PageState.error('Erro ao criar usuário')));
      }
    }
  }
}
