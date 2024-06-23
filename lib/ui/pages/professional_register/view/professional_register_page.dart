import 'package:barber/ui/pages/professional_register/bloc/professional_register_bloc.dart';
import 'package:barber/ui/pages/professional_register/view/professional_register_view.dart';
import 'package:barber/ui/widgets/base_app_bar.dart';
import 'package:barber/utils/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfessionalRegisterPage extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => const ProfessionalRegisterPage());

  const ProfessionalRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfessionalRegisterBloc>(
      create: (context) => ProfessionalRegisterBloc(),
      child: BlocListener<ProfessionalRegisterBloc, ProfessionalRegisterState>(
        listenWhen: (previous, current) =>
            previous.itemState != current.itemState,
        listener: (context, state) async {
          if (state.itemState.status == PageStatus.success) {
            // dynamic result = await Navigator.of(context, rootNavigator: true)
            //     .push(ProfessionalRegisterView.route(user: state.itemState.data));
            Fluttertoast.showToast(msg: "Categoria do usuário atualizada");
          } else {
            Fluttertoast.showToast(msg: "Erro ao salvar categoria do usuário");
          }
        },
        child: const Scaffold(
          appBar: BaseAppBar(title: 'Registro de profissionais'),
          body: ProfessionalRegisterView(),
        ),
      ),
    );
  }
}
