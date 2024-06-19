import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/main.dart';
import 'package:barber/repositories/repositories.dart';
import 'package:barber/ui/pages/home/bloc/home_bloc.dart';
import 'package:barber/ui/pages/location/view/location_page.dart';
import 'package:barber/ui/pages/login/login.dart';
import 'package:barber/ui/pages/profile/view/view.dart';
import 'package:barber/ui/pages/schedule/view/schedule_page.dart';
import 'package:barber/ui/pages/services/view/service_page.dart';
import 'package:barber/ui/widgets/base_card.dart';
import 'package:barber/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(context.read<UserRepository>()),
          child: BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) => previous.state != current.state,
            listener: (context, state) {
              if (state.state.status == PageStatus.success) {
                globalKey.currentState?.pushReplacement(LoginPage.route());
              }
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      HeaderButtons(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: _addLogo(),
                      ),
                      HomeButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _addLogo() {
    return SizedBox(
      height: 100,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}

class HeaderButtons extends StatelessWidget {
  const HeaderButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Tooltip(
            message: "Notificações",
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                splashRadius: 16,
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 20,
                ),
              ),
            ),
          ),
          Tooltip(
            message: '',
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                splashRadius: 16,
                onPressed: () => context.read<HomeBloc>().add(HomeLogout()),
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeButtons extends StatelessWidget {
  const HomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeCard(
            title: "Agendar",
            icon: 'assets/icons/calendar.svg',
            onTap: () => Navigator.of(context).push(SchedulePage.route()),
          ),
          12.toSizedBoxH(),
          HomeCard(
            title: "Meus agendamentos",
            icon: 'assets/icons/clipboard_check.svg',
            onTap: () {},
          ),
          12.toSizedBoxH(),
          HomeCard(
            title: "Serviços",
            icon: 'assets/icons/scissors.svg',
            onTap: () => Navigator.of(context).push(ServicePage.route()),
          ),
          12.toSizedBoxH(),
          HomeCard(
            title: "Histórico",
            icon: 'assets/icons/history.svg',
            onTap: () {},
          ),
          12.toSizedBoxH(),
          HomeCard(
            title: "Meu perfil",
            icon: 'assets/icons/user.svg',
            onTap: () => Navigator.of(context).push(ProfilePage.route()),
          ),
          12.toSizedBoxH(),
          HomeCard(
            title: "Localização",
            icon: 'assets/icons/location.svg',
            onTap: () => Navigator.of(context).push(LocationPage.route()),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({this.title, this.onTap, this.icon});

  final String? title;
  final GestureTapCallback? onTap;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Color(0xffFFF112), borderRadius: BorderRadius.circular(6)),
          child: SvgPicture.asset(
            icon ?? '',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ),
        title: Text(
          title ?? '',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
