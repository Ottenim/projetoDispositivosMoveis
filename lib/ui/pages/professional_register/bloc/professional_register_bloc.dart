import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/services/services.dart';
import 'package:barber/utils/page_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'professional_register_event.dart';
part 'professional_register_state.dart';

class ProfessionalRegisterBloc
    extends Bloc<ProfessionalRegisterEvent, ProfessionalRegisterState> {
  ProfessionalRegisterBloc() : super(ProfessionalRegisterState()) {
    on<UsersFetch>(_onFetch);
    on<UserCategoryChanged>(_onUserCategoryChanged);
  }

  final UserService userService = UserService();

  FutureOr<void> _onFetch(
    UsersFetch event,
    Emitter<ProfessionalRegisterState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading()));

    try {
      List<User> users = await userService.getUsersByCategory([1, 2]);

      emit(state.copyWith(state: PageState.success(), users: users));
    } catch (e) {
      emit(state.copyWith(state: PageState.error()));
    }
  }

  FutureOr<void> _onUserCategoryChanged(
    UserCategoryChanged event,
    Emitter<ProfessionalRegisterState> emit,
  ) async {
    emit(state.copyWith(itemState: PageState.loading()));

    try {
      await userService.updateUser(event.user.id!,
          event.user.copyWith(userCategory: event.userCategory));

      emit(state.copyWith(itemState: PageState.success(data: event.user)));
    } catch (e) {
      emit(state.copyWith(itemState: PageState.error()));
    }
  }
}
