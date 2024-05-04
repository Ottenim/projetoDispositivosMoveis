import 'package:barber/ui/widgets/botao_continuar.dart';
import 'package:barber/ui/widgets/campo_email.dart';
import 'package:barber/ui/widgets/campo_senha.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
          child: Column(
        children: [
          PasswordField(controller: _controller),
          EmailFieldWidget(controller: _controller),
          Text("Bem-vindo à Home Page!"),
          BotaoContinuar(text: "Continuar", onClicked: () {})
        ],
      )),
    );
  }
}
