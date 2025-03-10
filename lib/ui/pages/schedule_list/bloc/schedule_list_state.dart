part of 'schedule_list_bloc.dart';

class ScheduleListState extends Equatable {
  const ScheduleListState(
      {this.state = const PageState(PageStatus.none),
      this.schedules = const [],
      this.professionals = const [],
      this.services = const []});

  final PageState state;
  final List<Scheduling> schedules;
  final List<User> professionals;
  final List<Service> services;

  ScheduleListState copyWith({
    List<User>? professionals,
    List<Service>? services,
    PageState? state,
    List<Scheduling>? schedules,
  }) {
    return ScheduleListState(
      state: state ?? this.state,
      schedules: schedules ?? this.schedules,
      professionals: professionals ?? this.professionals,
      services: services ?? this.services,
    );
  }

  @override
  List<Object?> get props => [state, schedules, professionals, services];
}
