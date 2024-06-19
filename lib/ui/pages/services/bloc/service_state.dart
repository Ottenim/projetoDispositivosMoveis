part of 'service_bloc.dart';

class ServiceState extends Equatable {
  const ServiceState({
    this.state = const PageState(PageStatus.none),
    this.itemState = const PageState(PageStatus.none),
    this.services = const [],
  });

  final PageState state;
  final PageState itemState;
  final List<Service> services;

  ServiceState copyWith({
    PageState? state,
    PageState? itemState,
    List<Service>? services,
  }) {
    return ServiceState(
      state: state ?? this.state,
      itemState: itemState ?? this.itemState,
      services: services ?? this.services,
    );
  }

  @override
  List<Object?> get props => [state, itemState, services];
}
