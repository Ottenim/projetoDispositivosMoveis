import 'package:barber/ui/widgets/campo_texto.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
          child: Column(
        children: [
          CampoTexto(
            icon: Icons.email_outlined,
            hint: 'E-mail',
          ),
          CampoTexto(
            icon: Icons.lock_outline_rounded,
            hint: 'Senha',
          ),
          Text("Bem-vindo à Home Page!"),
        ],
      )),
    );
  }
}
