part of 'service_bloc.dart';

class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ServiceFetch extends ServiceEvent {}

class ServiceItemTapped extends ServiceEvent {
  const ServiceItemTapped(this.service);

  final Service service;
}
