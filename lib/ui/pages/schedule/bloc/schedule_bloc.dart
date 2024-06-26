import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/repositories/repositories.dart';
import 'package:barber/services/schedule_service.dart';
import 'package:barber/services/service_service.dart';
import 'package:barber/services/services.dart';
import 'package:barber/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'schedule_event.dart';

part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(this.userRepository) : super(ScheduleState()) {
    on<ScheduleInitialEvent>(_onInit);
    on<ScheduleProfessionalChanged>(_onProfessionalChanged);
    on<ScheduleDateChanged>(_onDateChanged);
    on<ScheduleHourChanged>(_onHourChanged);
    on<ScheduleServiceChanged>(_onServiceChanged);
    on<ScheduleSave>(_onSave);
  }

  final UserRepository userRepository;

  final UserService userService = UserService();
  final ServiceService serviceService = ServiceService();
  final ScheduleService scheduleService = ScheduleService();

  final GlobalKey<FormState> formKey = GlobalKey();

  FutureOr<void> _onInit(
    ScheduleInitialEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading()));

    try {
      List<User> users = await userService.getUsersByCategory();
      List<String> hours = _buildAvailableHours();
      List<Service> services = await serviceService.getServices();

      emit(state.copyWith(state: PageState.none(), professionals: users, availableHours: hours, services: services));
    } catch (e) {
      emit(state.copyWith(state: PageState.error()));
    }
  }

  FutureOr<void> _onProfessionalChanged(
    ScheduleProfessionalChanged event,
    Emitter<ScheduleState> emit,
  ) {
    emit(state.copyWith(selectedProfessional: event.user));
  }

  FutureOr<void> _onDateChanged(
    ScheduleDateChanged event,
    Emitter<ScheduleState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.date));
  }

  FutureOr<void> _onHourChanged(
    ScheduleHourChanged event,
    Emitter<ScheduleState> emit,
  ) {
    emit(state.copyWith(selectedHour: event.hour));
  }

  FutureOr<void> _onServiceChanged(
    ScheduleServiceChanged event,
    Emitter<ScheduleState> emit,
  ) {
    emit(state.copyWith(selectedService: event.service));
  }

  List<String> _buildAvailableHours() {
    DateFormat formatter = DateFormat(DateFormat.HOUR24_MINUTE);

    List<String> hours = [];

    DateTime startTime = DateTime.now().copyWith(hour: 8, minute: 0, millisecond: 0, microsecond: 0);
    int startHour = startTime.hour;

    while (startHour <= 18) {
      hours.add(formatter.format(startTime));

      startTime = startTime.add(Duration(minutes: 30));

      startHour = startTime.hour;
    }

    return hours;
  }

  FutureOr<void> _onSave(
    ScheduleSave event,
    Emitter<ScheduleState> emit,
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(saveState: PageState.loading('Agendando horário')));

      try {
        DateTime? dateTime = DateFormat(DateFormat.HOUR24_MINUTE).parse(state.selectedHour ?? '');

        await scheduleService.addSchedule(
          Scheduling(
              hour: TimeOfDay.fromDateTime(dateTime),
              day: state.selectedDate,
              attendantId: state.selectedProfessional?.id,
              serviceId: state.selectedService?.id,
              clientId: userRepository.user.id),
        );

        emit(state.copyWith(saveState: PageState.success(info: 'Corte Agendado')));
      } catch (e) {
        emit(state.copyWith(saveState: PageState.error('Erro ao salvar horário')));
      }
    } else {
      emit(state.copyWith(saveState: PageState.error('Ah campos não válidos')));
    }
  }
}
