import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/models/report.dart';
import 'package:barber/services/schedule_service.dart';
import 'package:barber/services/service_service.dart';
import 'package:barber/services/services.dart';
import 'package:barber/utils/page_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(ReportsState()) {
    on<OnInitialDateChanged>(_onInitialDateChanged);
    on<OnFinalDateChanged>(_onFinalDateChanged);
    on<OnBtnClick>(_onBtnClick);
  }

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
    emit(state.copyWith(state: PageState.loading()));
    try {
      List<User> users = await userService.getUsersByCategory([1]);

      List<Report> reports = [];

      for (var user in users) {
        List<Scheduling> schedules =
            await scheduleService.getSchedulesByClientId(user.id!);
        double totalValue = 0;
        int totalDuration = 0;

        for (var schedule in schedules) {
          Service? service =
              await serviceService.getServiceById(schedule.serviceId!);
          if (service != null) {
            totalValue += service.value!;
            totalDuration += service.duration!;
          }
        }
        reports.add(Report(
          userName: user.name,
          userCpf: user.cpf,
          totalValue: totalValue,
          totalDuration: totalDuration,
        ));
      }

      emit(state.copyWith(state: PageState.success(), reports: reports));
    } catch (e) {
      emit(state.copyWith(state: PageState.error()));
    }
  }
}
