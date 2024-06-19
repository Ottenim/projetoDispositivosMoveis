import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/services/service_service.dart';
import 'package:barber/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_event.dart';

part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceState()) {
    on<ServiceFetch>(_onFetch);
    on<ServiceItemTapped>(_onItemTapped);
  }

  final ServiceService service = ServiceService();

  FutureOr<void> _onFetch(
    ServiceFetch event,
    Emitter<ServiceState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading()));

    try {
      List<Service> services = await service.getServices();

      emit(state.copyWith(state: PageState.success(), services: services));
    } catch (e) {
      emit(state.copyWith(state: PageState.error()));
    }
  }

  FutureOr<void> _onItemTapped(
    ServiceItemTapped event,
    Emitter<ServiceState> emit,
  ) {
    emit(state.copyWith(itemState: PageState.success(data: event.service)));
  }
}
