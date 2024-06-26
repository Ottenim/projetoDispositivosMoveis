import 'package:barber/repositories/repositories.dart';
import 'package:barber/ui/pages/schedule/bloc/schedule_bloc.dart';
import 'package:barber/ui/pages/schedule/view/schedule_view.dart';
import 'package:barber/ui/widgets/base_app_bar.dart';
import 'package:barber/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  static Route route() => MaterialPageRoute(builder: (context) => SchedulePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleBloc>(
      create: (context) => ScheduleBloc(context.read<UserRepository>())..add(ScheduleInitialEvent()),
      child: BlocListener<ScheduleBloc, ScheduleState>(
        listenWhen: (previous, current) => previous.saveState != current.saveState,
        listener: (context, state) {
          Fluttertoast.showToast(msg: state.saveState.info ?? '');

          if (state.saveState.status == PageStatus.success) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: BaseAppBar(title: 'Agendar'),
          body: ScheduleView(),
        ),
      ),
    );
  }
}
