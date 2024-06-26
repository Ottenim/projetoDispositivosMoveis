import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/repositories/repositories.dart';
import 'package:barber/services/schedule_service.dart';
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

  FutureOr<void> _onFetch(
    ScheduleListFetch event,
    Emitter<ScheduleListState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading()));

    try {
      List<Scheduling> schedules = await scheduleService.getSchedulesByClientId(userRepository.user.id ?? '');

      emit(state.copyWith(state: PageState.success(), schedules: schedules));
    } catch (e) {
      emit(state.copyWith(state: PageState.error()));
    }
  }
}
