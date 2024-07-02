import 'package:barber/models/models.dart';
import 'package:barber/ui/pages/schedule_list/bloc/schedule_list_bloc.dart';
import 'package:barber/ui/widgets/appointment.dart';
import 'package:barber/ui/widgets/base_card.dart';
import 'package:barber/ui/widgets/base_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScheduleListView extends StatelessWidget {
  const ScheduleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleListBloc, ScheduleListState>(
      buildWhen: (previous, current) => previous.state != current.state,
      builder: (context, state) => Column(
        children: [
          Expanded(
            child: BaseList(
              state: state.state,
              items: state.schedules,
              onRefresh: () =>
                  context.read<ScheduleListBloc>().add(ScheduleListFetch()),
              itemBuilder: (context, item) => AgendamentoWidget(
                date: item.day != null
                    ? DateFormat(DateFormat.YEAR_MONTH_DAY).format(item.day!)
                    : '',
                service: state.services
                    .firstWhere((e) => e.id == item.serviceId)
                    .name!,
                attendant: state.professionals
                        .where((e) => e.id == item.attendantId)
                        .firstOrNull
                        ?.name ??
                    "Não é mais um atendente",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  const ScheduleItem(this.scheduling, {super.key});

  final Scheduling scheduling;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(scheduling.day != null
          ? DateFormat(DateFormat.YEAR_MONTH_DAY).format(scheduling.day!)
          : ''),
    );
  }
}
