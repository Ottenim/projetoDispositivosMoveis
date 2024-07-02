import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/repositories/repositories.dart';
import 'package:barber/services/schedule_service.dart';
import 'package:barber/services/service_service.dart';
import 'package:barber/services/services.dart';
import 'package:barber/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_list_event.dart';
part 'schedule_list_state.dart';

class ScheduleListBloc extends Bloc<ScheduleListEvent, ScheduleListState> {
  ScheduleListBloc(this.userRepository) : super(ScheduleListState()) {
    on<ScheduleListFetch>(_onFetch);
  }

  final UserRepository userRepository;

  final ScheduleService scheduleService = ScheduleService();
  final UserService userService = UserService();
  final ServiceService serviceService = ServiceService();

  FutureOr<void> _onFetch(
    ScheduleListFetch event,
    Emitter<ScheduleListState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading()));

    try {
      List<Scheduling> schedules = await scheduleService
          .getSchedulesByClientId(userRepository.user.id ?? '');

      List<User> users = await userService.getUsersByCategory([1]);

      List<Service>? services = await serviceService.getServices();

      emit(state.copyWith(
          state: PageState.success(),
          schedules: schedules,
          professionals: users,
          services: services));
    } catch (e) {
      emit(state.copyWith(state: PageState.error()));
    }
  }
}
// Pegar todos agendamentos
// Agrupar usuários e valor
//
