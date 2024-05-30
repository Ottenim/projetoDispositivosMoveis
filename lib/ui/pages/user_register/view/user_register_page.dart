import 'package:barber/ui/pages/user_register/bloc/user_register_bloc.dart';
import 'package:barber/ui/pages/user_register/view/user_register_view.dart';
import 'package:barber/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserRegisterPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const UserRegisterPage());

  const UserRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRegisterBloc>(
      create: (context) => UserRegisterBloc(),
      child: BlocListener<UserRegisterBloc, UserRegisterState>(
        listenWhen: (previous, current) => previous.state != current.state,
        listener: (context, state) {
          if (state.state.status == PageStatus.success) {
            Fluttertoast.showToast(msg: 'Usuário criado!');

            Navigator.of(context).pop();
          } else {
            Fluttertoast.showToast(msg: state.state.info ?? '');
          }
        },
        child: Scaffold(
          body: UserRegisterView(),
        ),
      ),
    );
  }
}
