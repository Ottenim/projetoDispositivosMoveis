import 'package:barber/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:barber/ui/pages/profile/view/profile_view.dart';
import 'package:barber/ui/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => ProfilePage());

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        appBar: BaseAppBar(title: 'Perfil'),
        body: ProfileView(),
      ),
    );
  }
}
