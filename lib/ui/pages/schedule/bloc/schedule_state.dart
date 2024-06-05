part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();
}

final class ScheduleInitial extends ScheduleState {
  @override
  List<Object> get props => [];
}
