import 'package:barber/ui/pages/service_form/view/service_form_page.dart';
import 'package:barber/ui/pages/services/bloc/service_bloc.dart';
import 'package:barber/ui/pages/services/view/service_view.dart';
import 'package:barber/ui/widgets/widgets.dart';
import 'package:barber/utils/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => ServicePage());

  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc()..add(ServiceFetch()),
      child: BlocListener<ServiceBloc, ServiceState>(
        listenWhen: (previous, current) => previous.itemState != current.itemState,
        listener: (context, state) async {
          if (state.itemState.status == PageStatus.success) {
            dynamic result = await Navigator.of(context, rootNavigator: true).push(ServiceFormPage.route(service: state.itemState.data));

            if (result != null) {
              context.read<ServiceBloc>().add(ServiceFetch());
            }
          }
        },
        child: Scaffold(
          appBar: BaseAppBar(title: 'Serviços'),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => Navigator.of(context, rootNavigator: true).push(ServiceFormPage.route()),
            child: Icon(Icons.add),
          ),
          body: ServiceView(),
        ),
      ),
    );
  }
}
