import 'dart:async';

import 'package:barber/models/models.dart';
import 'package:barber/services/service_service.dart';
import 'package:barber/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

part 'service_form_event.dart';
part 'service_form_state.dart';

class ServiceFormBloc extends Bloc<ServiceFormEvent, ServiceFormState> {
  ServiceFormBloc(this.service) : super(ServiceFormState()) {
    on<ServiceFormInitialEvent>(_onInit);
    on<ServiceFormNameChanged>(_onNameChanged);
    on<ServiceFormDurationChanged>(_onDurationChanged);
    on<ServiceFormValueChanged>(_onValueChanged);
    on<ServiceFormInfoChanged>(_onInfoChanged);
    on<ServiceFormAdd>(_onAdd);
    on<ServiceFormUpdate>(_onUpdate);
    on<ServiceFormDelete>(_onDelete);

    valueMask = MaskTextInputFormatter(
        mask: 'R\$ ##,##', initialText: service?.value.toString() ?? '');
    durationMask = MaskTextInputFormatter(
        mask: '###', initialText: service?.duration.toString());
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ServiceService services = ServiceService();
  final Service? service;

  late MaskTextInputFormatter valueMask;
  late MaskTextInputFormatter durationMask;

  FutureOr<void> _onInit(
    ServiceFormInitialEvent event,
    Emitter<ServiceFormState> emit,
  ) {
    emit(state.copyWith(initState: PageState.loading()));

    if (service != null) {
      emit(state.copyWith(
          name: service?.name,
          info: service?.info,
          duration: durationMask.maskText(service?.duration.toString() ?? ''),
          value: valueMask.maskText(service?.value.toString() ?? '')));
    }

    emit(state.copyWith(initState: PageState.none()));
  }

  FutureOr<void> _onNameChanged(
    ServiceFormNameChanged event,
    Emitter<ServiceFormState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onDurationChanged(
    ServiceFormDurationChanged event,
    Emitter<ServiceFormState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  FutureOr<void> _onValueChanged(
    ServiceFormValueChanged event,
    Emitter<ServiceFormState> emit,
  ) {
    emit(state.copyWith(value: event.value));
  }

  FutureOr<void> _onInfoChanged(
    ServiceFormInfoChanged event,
    Emitter<ServiceFormState> emit,
  ) {
    emit(state.copyWith(info: event.info));
  }

  FutureOr<void> _onAdd(
    ServiceFormAdd event,
    Emitter<ServiceFormState> emit,
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(state: PageState.loading('Salvando serviço...')));

      try {
        Service service = Service(
          name: state.name,
          value: double.parse(
              state.value.replaceFirst('R\$', '').replaceFirst(',', '.')),
          duration: int.parse(state.duration),
          info: state.info,
        );

        await services.add(service);

        emit(state.copyWith(
            state: PageState.success(info: 'Serviço salvo', data: service)));
      } catch (e) {
        emit(state.copyWith(
            state: PageState.error('Não foi possivel salvar o serviço')));
      }
    } else {
      emit(state.copyWith(state: PageState.error('Campos incorretos')));
    }
  }

  FutureOr<void> _onUpdate(
    ServiceFormUpdate event,
    Emitter<ServiceFormState> emit,
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(state: PageState.loading('Atualizando serviço...')));

      try {
        Service newService;

        await services.update(
            service?.id ?? '',
            newService = service!.copyWith(
              name: state.name,
              value: double.parse(
                  state.value.replaceFirst('R\$', '').replaceFirst(',', '.')),
              duration: int.parse(state.duration),
              info: state.info,
            ));

        emit(state.copyWith(
            state: PageState.success(info: 'Serviço salvo', data: newService)));
      } catch (e) {
        emit(state.copyWith(
            state: PageState.error('Não foi possivel atualizar o serviço')));
      }
    } else {
      emit(state.copyWith(state: PageState.error('Campos incorretos')));
    }
  }

  FutureOr<void> _onDelete(
    ServiceFormDelete event,
    Emitter<ServiceFormState> emit,
  ) async {
    emit(state.copyWith(state: PageState.loading('Deletando serviço...')));
    try {
      await services.delete(service!.id!);
      emit(state.copyWith(state: PageState.success()));
    } catch (e) {
      emit(state.copyWith(
          state: PageState.error('Não foi possivel deletar o serviço')));
    }
  }
}
