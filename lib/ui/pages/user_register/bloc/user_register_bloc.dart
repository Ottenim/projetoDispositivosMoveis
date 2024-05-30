import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/services/services.dart';
import 'package:barber/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_register_event.dart';

part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  UserRegisterBloc() : super(const UserRegisterState()) {
    on<UserRegisterNameChanged>(_onNameChanged);
    on<UserRegisterCpfChanged>(_onCpfChanged);
    on<UserRegisterPasswordChanged>(_onPasswordChanged);
    on<UserRegisterCreate>(_onCreate);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final UserService userService = UserService();

  FutureOr<void> _onNameChanged(
    UserRegisterNameChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onCpfChanged(
    UserRegisterCpfChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    emit(state.copyWith(cpf: event.cpf));
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
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(state: PageState.loading('Criando usuário')));

      try {
        User? exists = await userService.getUserByCpf(state.cpf);

        if (exists == null) {
          User user = User(name: state.name, cpf: state.cpf, password: state.password);

          user = user.copyWith(id: await userService.addUser(user));

          emit(state.copyWith(state: PageState.success(info: 'Usuário criado', data: user)));
        } else {
          emit(state.copyWith(state: PageState.error('Usuário existente')));
        }
      } catch (e) {
        emit(state.copyWith(state: PageState.error('Erro ao criar usuário')));
      }
    }
  }
}
