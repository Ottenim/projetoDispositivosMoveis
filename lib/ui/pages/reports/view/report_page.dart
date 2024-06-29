import 'package:barber/ui/pages/reports/bloc/reports_bloc.dart';
import 'package:barber/ui/pages/reports/view/report_view.dart';
import 'package:barber/ui/widgets/base_app_bar.dart';
import 'package:barber/utils/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportPage extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => const ReportPage());

  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportsBloc>(
      create: (context) => ReportsBloc(),
      child: BlocListener<ReportsBloc, ReportsState>(
        listenWhen: (previous, current) => previous.state != current.state,
        listener: (context, state) async {
          if (state.state.status == PageStatus.success) {
            Fluttertoast.showToast(msg: "Gerando relatório");
          }
        },
        child: Scaffold(
          appBar: BaseAppBar(title: 'Relatório'),
          body: ReportView(),
        ),
      ),
    );
  }
}
