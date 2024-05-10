import 'package:barber/ui/widgets/botao_padrao.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: SingleChildScrollView(
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
              _addBotoes(),
            ],
          ),
        ),
      );
    });
  }

  Widget _addNotificationWidget(
      BuildContext context, Function(BuildContext) onClick) {
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
                  onClick.call(context);
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

  Widget _addBotoes() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BotaoPadrao(
            titulo: "Agendar",
            onClick: () {},
            iconData: Icons.date_range_outlined,
          ),
          BotaoPadrao(
              titulo: "Agendamentos",
              onClick: () {},
              iconData: Icons.event_available_outlined),
          BotaoPadrao(
              titulo: "Lucros",
              onClick: () {},
              iconData: Icons.attach_money_outlined),
          BotaoPadrao(
              titulo: "Serviços",
              onClick: () {},
              iconData: Icons.history_outlined),
          BotaoPadrao(
              titulo: "Histórico", onClick: () {}, iconData: Icons.content_cut),
        ],
      ),
    );
  }
}
