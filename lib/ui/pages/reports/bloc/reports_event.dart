part of 'reports_bloc.dart';

class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class OnBtnClick extends ReportsEvent {}

class OnInitialDateChanged extends ReportsEvent {
  const OnInitialDateChanged(this.initialDate);

  final DateTime? initialDate;
}

class OnFinalDateChanged extends ReportsEvent {
  const OnFinalDateChanged(this.finalDate);

  final DateTime? finalDate;
}
