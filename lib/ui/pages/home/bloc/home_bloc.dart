import 'dart:async';

import 'package:barber/repositories/repositories.dart';
import 'package:barber/utils/prefs.dart';
import 'package:barber/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.userRepository) : super(HomeState()) {
    on<HomeLogout>(_onLogout);
  }

  final UserRepository userRepository;

  FutureOr<void> _onLogout(
    HomeLogout event,
    Emitter<HomeState> emit,
  ) async {
    await Prefs.clear();

    emit(state.copyWith(state: PageState.success()));
  }
}
