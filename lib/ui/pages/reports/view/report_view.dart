import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/models/report.dart';
import 'package:barber/ui/pages/reports/bloc/reports_bloc.dart';
import 'package:barber/ui/widgets/base_card.dart';
import 'package:barber/ui/widgets/base_list.dart';
import 'package:barber/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _addTitleDates(),
          10.toSizedBoxH(),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: context.read<ReportsBloc>().formKey,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: BlocBuilder<ReportsBloc, ReportsState>(
                    buildWhen: (previous, current) => previous.initialDate != current.initialDate || previous.finalDate != current.finalDate,
                    builder: (context, state) => BaseDatePicker(
                      hint: '00/00/0000',
                      initialValue: state.initialDate,
                      validator: (value) => value == null
                          ? 'Campo Obrigatório'
                          : value.isAfter(DateTime.now().copyWith(second: 0, microsecond: 0, millisecond: 0, minute: 0, hour: 0))
                              ? 'A data deve ser anterior à data atual'
                              : state.initialDate.isAfter(state.finalDate)
                                  ? 'Data inicial deve ser anterior à data final'
                                  : null,
                      onChanged: (value) => context.read<ReportsBloc>().add(OnInitialDateChanged(value)),
                    ),
                  ),
                ),
                10.toSizedBoxW(),
                Expanded(
                  child: BlocBuilder<ReportsBloc, ReportsState>(
                    buildWhen: (previous, current) => previous.finalDate != current.finalDate || previous.initialDate != current.initialDate,
                    builder: (context, state) => BaseDatePicker(
                      hint: '00/00/0000',
                      initialValue: state.finalDate,
                      validator: (value) => value == null
                          ? 'Campo Obrigatório'
                          : value.isAfter(DateTime.now().copyWith(second: 0, microsecond: 0, millisecond: 0, minute: 0, hour: 0))
                              ? 'A data deve ser anterior à data atual'
                              : state.finalDate.isBefore(state.initialDate)
                                  ? 'Data final deve ser maior que à data inicial'
                                  : null,
                      onChanged: (value) => context.read<ReportsBloc>().add(OnFinalDateChanged(value)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.toSizedBoxH(),
          BlocBuilder<ReportsBloc, ReportsState>(
            buildWhen: (previous, current) => previous.state != current.state,
            builder: (context, state) {
              return Expanded(
                child: BaseList(
                  items: state.reports,
                  state: state.state,
                  onRefresh: () => context.read<ReportsBloc>().add(OnBtnClick()),
                  itemBuilder: (context, item) => ProfessionalReportCard(item),
                ),
              );
            },
          ),
          FloatingActionButton.small(
            onPressed: () => context.read<ReportsBloc>().add(OnBtnClick()),
            child: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }

  Widget _addTitleDates() {
    return Column(
      children: [
        Row(
          children: [
            10.toSizedBoxW(),
            Expanded(
              flex: 1,
              child: Container(
                height: 1,
                color: const Color(0xffFFF112),
              ),
            ),
            10.toSizedBoxW(),
            const Expanded(
              flex: 1,
              child: Text(
                "Data Inicial",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            10.toSizedBoxW(),
            Expanded(
              flex: 1,
              child: Container(
                height: 1,
                color: const Color(0xffFFF112),
              ),
            ),
            10.toSizedBoxW(),
            const Expanded(
              flex: 1,
              child: const Text(
                "Data Final",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            10.toSizedBoxW(),
            Expanded(
              flex: 1,
              child: Container(
                height: 1,
                color: const Color(0xffFFF112),
              ),
            ),
            10.toSizedBoxW(),
          ],
        ),
      ],
    );
  }
}

class ProfessionalReportCard extends StatelessWidget {
  final Report report;

  const ProfessionalReportCard(this.report, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: () {},
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black87.withOpacity(0.5))]),
                  child: Column(
                    children: [
                      Text("Nome: ${report.userName}"),
                      Text("CPF: ${report.userCpf}"),
                      Text("Tempo de trabalho: ${report.totalDuration} minutos"),
                      Text("Total recebido: R\$ ${report.totalValue}")
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
