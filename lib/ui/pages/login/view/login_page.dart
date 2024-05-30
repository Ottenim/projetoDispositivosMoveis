import 'package:barber/repositories/repositories.dart';
import 'package:barber/ui/pages/home_page.dart';
import 'package:barber/ui/pages/login/bloc/login_bloc.dart';
import 'package:barber/ui/pages/login/view/login_view.dart';
import 'package:barber/utils/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => LoginPage());

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(context.read<UserRepository>()),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.state != current.state,
        listener: (context, state) {
          if (state.state.status == PageStatus.success) {
            Navigator.of(context).push(HomePage.route());
          } else {
            Fluttertoast.showToast(msg: state.state.info ?? '');
          }
        },
        child: Scaffold(body: LoginView()),
      ),
    );
  }
}
