part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  const ScheduleState({
    this.state = const PageState(PageStatus.loading),
    this.saveState = const PageState(PageStatus.none),
    this.professionals = const [],
    this.availableHours = const [],
    this.services = const [],
    this.selectedProfessional,
    this.selectedHour,
    this.selectedDate,
    this.selectedService,
  });

  final PageState state;
  final PageState saveState;

  final List<User> professionals;
  final List<String> availableHours;
  final List<Service> services;

  final User? selectedProfessional;
  final String? selectedHour;
  final DateTime? selectedDate;
  final Service? selectedService;

  ScheduleState copyWith({
    PageState? state,
    PageState? saveState,
    List<User>? professionals,
    List<String>? availableHours,
    List<Service>? services,
    User? selectedProfessional,
    String? selectedHour,
    DateTime? selectedDate,
    Service? selectedService,
  }) {
    return ScheduleState(
      state: state ?? this.state,
      saveState: saveState ?? this.saveState,
      professionals: professionals ?? this.professionals,
      availableHours: availableHours ?? this.availableHours,
      services: services ?? this.services,
      selectedProfessional: selectedProfessional ?? this.selectedProfessional,
      selectedHour: selectedHour ?? this.selectedHour,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedService: selectedService ?? this.selectedService,
    );
  }

  @override
  List<Object?> get props => [
        state,
        saveState,
        professionals,
        availableHours,
        services,
        selectedProfessional,
        selectedHour,
        selectedDate,
        selectedService,
      ];
}
