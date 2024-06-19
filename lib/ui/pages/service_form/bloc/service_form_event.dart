part of 'service_form_bloc.dart';

class ServiceFormEvent extends Equatable {
  const ServiceFormEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ServiceFormInitialEvent extends ServiceFormEvent {}

class ServiceFormNameChanged extends ServiceFormEvent {
  const ServiceFormNameChanged(this.name);

  final String name;
}

class ServiceFormDurationChanged extends ServiceFormEvent {
  const ServiceFormDurationChanged(this.duration);

  final String duration;
}

class ServiceFormValueChanged extends ServiceFormEvent {
  const ServiceFormValueChanged(this.value);

  final String value;
}

class ServiceFormInfoChanged extends ServiceFormEvent {
  const ServiceFormInfoChanged(this.info);

  final String info;
}

class ServiceFormAdd extends ServiceFormEvent {}

class ServiceFormUpdate extends ServiceFormEvent {}
