import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/models/report.dart';
import 'package:barber/services/schedule_service.dart';
import 'package:barber/services/service_service.dart';
import 'package:barber/services/services.dart';
import 'package:barber/utils/page_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(ReportsState()) {
    on<OnInitialDateChanged>(_onInitialDateChanged);
    on<OnFinalDateChanged>(_onFinalDateChanged);
    on<OnBtnClick>(_onBtnClick);
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  final UserService userService = UserService();
  final ServiceService serviceService = ServiceService();
  final ScheduleService scheduleService = ScheduleService();

  FutureOr<void> _onInitialDateChanged(
    OnInitialDateChanged event,
    Emitter<ReportsState> emit,
  ) {
    emit(state.copyWith(initialDate: event.initialDate));
  }

  FutureOr<void> _onFinalDateChanged(
    OnFinalDateChanged event,
    Emitter<ReportsState> emit,
  ) {
    emit(state.copyWith(finalDate: event.finalDate));
  }

  FutureOr<void> _onBtnClick(
    OnBtnClick event,
    Emitter<ReportsState> emit,
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(state: PageState.loading()));
      try {
        List<Scheduling> schedules = await scheduleService.getSchedules(state.initialDate, state.finalDate);
        List<User> professionals = await userService.getUsersByCategory([UserCategory.barber.index]);

        Map<String, User> professionalsCache = {};
        Map<String, int> timeWorking = {};
        Map<String, double> professionalValues = {};
        Map<String, Service> servicesCache = {};

        for (Scheduling scheduling in schedules) {
          Service? service;

          if (!servicesCache.containsKey(scheduling.serviceId)) {
            service = await serviceService.getServiceById(scheduling.serviceId ?? '');

            if (service != null) {
              servicesCache.putIfAbsent(service.id ?? '', () => service!);
            }
          } else {
            service = servicesCache[scheduling.serviceId];
          }

          User? professional;

          if (!professionalsCache.containsKey(scheduling.attendantId)) {
            professional = professionals.firstWhereOrNull((element) => element.id == scheduling.attendantId);

            if (professional != null) {
              professionalsCache.putIfAbsent(professional.id ?? '', () => professional!);
            }
          } else {
            professional = professionalsCache[scheduling.attendantId];
          }

          timeWorking.update(scheduling.attendantId ?? '', (value) => (service?.duration ?? 0) + value, ifAbsent: () => service?.duration ?? 0);
          professionalValues.update(scheduling.attendantId ?? '', (value) => (service?.value ?? 0) + value, ifAbsent: () => service?.value ?? 0);
        }

        List<Report> reports = [];

        for (MapEntry<String, User> entry in professionalsCache.entries) {
          reports.add(Report(
            userName: entry.value.name,
            userCpf: entry.value.cpf,
            totalValue: professionalValues[entry.key],
            totalDuration: timeWorking[entry.key],
          ));
        }

        emit(state.copyWith(state: PageState.success(), reports: reports));
      } catch (e) {
        emit(state.copyWith(state: PageState.error()));
      }
    } else {
      emit(state.copyWith(state: PageState.error('Campos obrigatórios não preenchidos')));
    }
  }
}
