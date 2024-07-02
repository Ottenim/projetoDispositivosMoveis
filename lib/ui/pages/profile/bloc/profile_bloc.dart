import 'dart:async';
import 'dart:io';
import 'package:barber/models/models.dart';
import 'package:barber/repositories/repositories.dart';
import 'package:barber/services/services.dart';
import 'package:barber/ui/pages/authentication/authentication_bloc.dart';
import 'package:barber/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.userRepository, this.authenticationBloc) : super(ProfileState()) {
    on<ProfileNameChanged>(_onNameChanged);
    on<ProfileCpfChanged>(_onCpfChanged);
    on<ProfilePasswordChanged>(_onPasswordChanged);
    on<ProfileImageChanged>(_onImageChanged);
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

  FutureOr<void> _onImageChanged(
    ProfileImageChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(imagePath: event.imagePath));
  }

  FutureOr<void> _onSaveChanges(
    ProfileSaveChanges event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading('Salvando usuário')));

    try {
      User user = userRepository.user;

      String? imageUrl = '';
      if (state.imagePath.isNotEmpty) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        final uploadTask = storageRef.putFile(File(state.imagePath!));
        final snapshot = await uploadTask.whenComplete(() => null);
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      await userService.updateUser(
        user.id ?? '',
        user = user.copyWith(
          name: state.name.isNotEmpty ? state.name : null,
          cpf: state.cpf.isNotEmpty ? state.cpf : null,
          password: state.newPassword.isNotEmpty ? state.newPassword : null,
          imageUrl: imageUrl,
        ),
      );

      await userRepository.setUser(user.id ?? '', user.toMap());

      emit(state.copyWith(state: PageState.success(info: 'Usuário atualizado', data: user)));
    } catch (e) {
      emit(state.copyWith(state: PageState.error('Erro ao salvar usuário: $e')));
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
