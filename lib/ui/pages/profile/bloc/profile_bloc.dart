import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/repositories/repositories.dart';
import 'package:barber/services/services.dart';
import 'package:barber/ui/pages/authentication/authentication_bloc.dart';
import 'package:barber/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.userRepository, this.authenticationBloc) : super(ProfileState()) {
    on<ProfileNameChanged>(_onNameChanged);
    on<ProfileCpfChanged>(_onCpfChanged);
    on<ProfilePasswordChanged>(_onPasswordChanged);
    on<ProfileSaveChanges>(_onSaveChanges);
    on<ProfileDeleteAccount>(_onDeleteAccount);
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final UserService userService = UserService();

  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  FutureOr<void> _onNameChanged(
    ProfileNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onCpfChanged(
    ProfileCpfChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(cpf: event.cpf));
  }

  FutureOr<void> _onPasswordChanged(
    ProfilePasswordChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(newPassword: event.password));
  }

  FutureOr<void> _onSaveChanges(
    ProfileSaveChanges event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading('Salvando usuário')));

    try {
      User user = userRepository.user;

      await userService.updateUser(
          user.id ?? '',
          user = user.copyWith(
            name: state.name.isNotEmpty ? state.name : null,
            cpf: state.cpf.isNotEmpty ? state.cpf : null,
            password: state.newPassword.isNotEmpty ? state.newPassword : null,
          ));

      await userRepository.setUser(user.id ?? '', user.toMap());

      emit(state.copyWith(state: PageState.success(info: 'Usuário atualizado', data: user)));
    } catch (e) {
      emit(state.copyWith(state: PageState.error('Erro ao salvar usuário')));
    }
  }

  FutureOr<void> _onDeleteAccount(
    ProfileDeleteAccount event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading('Deletando usuário')));

    try {
      await userService.deleteUser(userRepository.user.id ?? '');

      await Prefs.setString(PrefsKeys.userProperty, null);

      emit(state.copyWith(state: PageState.success(data: true)));
    } catch (e) {
      emit(state.copyWith(state: PageState.error('Não foi possivel deletar a conta')));
    }
  }
}
