part of 'appointment_bloc.dart';

sealed class AppointmentState extends Equatable {
  const AppointmentState();
}

final class AppointmentInitial extends AppointmentState {
  @override
  List<Object> get props => [];
}
