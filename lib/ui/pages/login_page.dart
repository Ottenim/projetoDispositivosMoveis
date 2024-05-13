import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/ui/pages/home_page.dart';
import 'package:barber/ui/widgets/botao_continuar.dart';
import 'package:barber/ui/widgets/campo_email.dart';
import 'package:barber/ui/widgets/campo_senha.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                Text(
                  "Bem vindo!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  "Entre na sua conta",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            20.toSizedBoxH(),
            EmailFieldWidget(controller: _controller),
            PasswordField(controller: _controller),
            _widgetEsqueceuSenha(context),
            20.toSizedBoxH(),
            BotaoContinuar(
              text: "Continuar",
              onClicked: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            20.toSizedBoxH(),
            _widgetNovaConta(context),
          ],
        ),
      )),
    );
  }

  Widget _widgetEsqueceuSenha(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
            );*/
          },
          child: const Text(
            'Esqueci minha senha',
            style: TextStyle(
              color: Color(0xFFFFF112),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _widgetNovaConta(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ainda não tem uma conta? ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          InkWell(
            onTap: () {
              /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateAccountPage()),
              );*/
            },
            child: Text(
              'Crie agora',
              style: TextStyle(
                color: Color(0xFFFFF112), // Cor do texto clicável
                decoration: TextDecoration.underline, // Adiciona o underline
              ),
            ),
          ),
        ],
      ),
    );
  }
}
