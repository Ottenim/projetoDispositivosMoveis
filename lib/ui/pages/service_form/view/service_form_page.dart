import 'package:barber/models/models.dart';
import 'package:barber/ui/pages/service_form/bloc/service_form_bloc.dart';
import 'package:barber/ui/pages/service_form/view/service_form_view.dart';
import 'package:barber/ui/widgets/base_app_bar.dart';
import 'package:barber/ui/widgets/widgets.dart';
import 'package:barber/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceFormPage extends StatelessWidget {
  static Route route({Service? service}) => MaterialPageRoute(builder: (context) => ServiceFormPage(service));

  const ServiceFormPage([this.service]);

  final Service? service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceFormBloc>(
      create: (context) => ServiceFormBloc(service)..add(ServiceFormInitialEvent()),
      child: BlocListener<ServiceFormBloc, ServiceFormState>(
        listenWhen: (previous, current) => previous.state != current.state,
        listener: (context, state) {
          if (state.state.info != null) {
            Fluttertoast.showToast(msg: state.state.info!);
          }

          if (state.state.status == PageStatus.success) {
            Navigator.of(context).pop(state.state.data);
          }
        },
        child: Scaffold(
          appBar: BaseAppBar(title: 'Cadastro de Serviço'),
          body: ServiceFormView(),
        ),
      ),
    );
  }
}
