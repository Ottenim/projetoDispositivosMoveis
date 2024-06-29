part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  ReportsState({
    this.professionals = const [],
    this.state = const PageState(PageStatus.none),
    this.reports = const [],
    this.services = const [],
    DateTime? initialDate,
    DateTime? finalDate,
  })  : initialDate = initialDate ?? DateTime.utc(2024, 01, 01),
        finalDate = finalDate ?? DateTime.utc(2024, 01, 01);

  final List<User> professionals;
  final List<Service> services;
  final PageState state;
  final DateTime initialDate;
  final DateTime finalDate;
  final List<Report> reports;

  ReportsState copyWith({
    List<User>? professionals,
    List<Service>? services,
    PageState? state,
    List<Report>? reports,
    DateTime? initialDate,
    DateTime? finalDate,
  }) {
    return ReportsState(
      professionals: professionals ?? this.professionals,
      services: services ?? this.services,
      state: state ?? this.state,
      reports: reports ?? this.reports,
      initialDate: initialDate ?? this.initialDate,
      finalDate: finalDate ?? this.finalDate,
    );
  }

  @override
  List<Object?> get props =>
      [professionals, services, state, reports, initialDate, finalDate];
}
