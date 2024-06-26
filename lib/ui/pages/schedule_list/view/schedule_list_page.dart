import 'package:barber/repositories/repositories.dart';
import 'package:barber/ui/pages/schedule_list/bloc/schedule_list_bloc.dart';
import 'package:barber/ui/pages/schedule_list/view/view.dart';
import 'package:barber/ui/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleListPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => ScheduleListPage());

  const ScheduleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleListBloc(context.read<UserRepository>())..add(ScheduleListFetch()),
      child: Scaffold(
        appBar: BaseAppBar(title: 'Meus Agendamentos'),
        body: ScheduleListView(),
      ),
    );
  }
}
