import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/ui/pages/profile/view/view.dart';
import 'package:barber/ui/widgets/base_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
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
                  _addNotificationWidget(context, (ctx) => {}),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: _addLogo(),
                  ),
                  HomeButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _addNotificationWidget(BuildContext context, Function(BuildContext) onPressed) {
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
                onPressed: () {
                  onPressed.call(context);
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addLogo() {
    return SizedBox(
      height: 100,
      child: Image.asset('assets/images/logo.png'),
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
            onTap: () {},
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
            onTap: () {},
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
