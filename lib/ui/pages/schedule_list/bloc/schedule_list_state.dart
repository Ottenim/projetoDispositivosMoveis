part of 'schedule_list_bloc.dart';

class ScheduleListState extends Equatable {
  const ScheduleListState({
    this.state = const PageState(PageStatus.none),
    this.schedules = const [],
  });

  final PageState state;
  final List<Scheduling> schedules;

  ScheduleListState copyWith({
    PageState? state,
    List<Scheduling>? schedules,
  }) {
    return ScheduleListState(
      state: state ?? this.state,
      schedules: schedules ?? this.schedules,
    );
  }

  @override
  List<Object?> get props => [state, schedules];
}
