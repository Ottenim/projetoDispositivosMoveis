import 'package:barber/main.dart';
import 'package:barber/repositories/repositories.dart';
import 'package:barber/ui/pages/authentication/authentication_bloc.dart';
import 'package:barber/ui/pages/login/login.dart';
import 'package:barber/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:barber/ui/pages/profile/view/profile_view.dart';
import 'package:barber/ui/widgets/base_app_bar.dart';
import 'package:barber/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => ProfilePage());

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(context.read<UserRepository>(), context.read<AuthenticationBloc>()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => previous.state != current.state,
        listener: (context, state) {
          Fluttertoast.showToast(msg: state.state.info ?? '');

          if (state.state.status == PageStatus.success && state.state.data != null) {
            if (state.state.data is bool) {
              globalKey.currentState?.pushReplacement(LoginPage.route());
            } else {
              Navigator.of(context).pop();
            }
          }
        },
        child: Scaffold(
          appBar: BaseAppBar(title: 'Perfil'),
          body: ProfileView(context.read<UserRepository>().user),
        ),
      ),
    );
  }
}
