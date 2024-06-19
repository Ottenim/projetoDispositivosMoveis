part of 'service_form_bloc.dart';

class ServiceFormState extends Equatable {
  const ServiceFormState({
    this.state = const PageState(PageStatus.none),
    this.initState = const PageState(PageStatus.loading),
    this.name = '',
    this.info = '',
    this.duration = '',
    this.value = '',
  });

  final PageState state;
  final PageState initState;
  final String name;
  final String duration;
  final String value;
  final String info;

  ServiceFormState copyWith({
    PageState? state,
    PageState? initState,
    String? name,
    String? duration,
    String? value,
    String? info,
  }) {
    return ServiceFormState(
      state: state ?? this.state,
      initState: initState ?? this.initState,
      name: name ?? this.name,
      info: info ?? this.info,
      duration: duration ?? this.duration,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [state, initState, name, info, duration, value];
}
