part of 'schedule_bloc.dart';

class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ScheduleInitialEvent extends ScheduleEvent {}

class ScheduleProfessionalChanged extends ScheduleEvent {
  const ScheduleProfessionalChanged(this.user);

  final User user;
}

class ScheduleDateChanged extends ScheduleEvent {
  const ScheduleDateChanged(this.date);

  final DateTime? date;
}

class ScheduleHourChanged extends ScheduleEvent {
  const ScheduleHourChanged(this.hour);

  final String? hour;
}

class ScheduleServiceChanged extends ScheduleEvent {
  const ScheduleServiceChanged(this.service);

  final Service? service;
}

class ScheduleSave extends ScheduleEvent {}
