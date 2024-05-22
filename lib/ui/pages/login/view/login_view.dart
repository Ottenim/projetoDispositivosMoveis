import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/ui/pages/home_page.dart';
import 'package:barber/ui/pages/login/login.dart';
import 'package:barber/ui/pages/user_register/view/user_register_page.dart';
import 'package:barber/ui/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            BaseTextField(
              hint: 'E-mail',
              prefixIcon: const Icon(Icons.email_outlined),
              autofillHints: const [AutofillHints.email],
              validator: (value) => EmailValidator.validate(value ?? '') ? 'Enter a valid email' : null,
              onChanged: (value) => context.read<LoginBloc>().add(LoginEmailChanged(value)),
            ),
            BaseTextField(
              hint: 'Senha',
              prefixIcon: Icon(Icons.lock_outline_rounded),
              keyboardType: TextInputType.visiblePassword,
              autofillHints: [AutofillHints.password],
              onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
            ),
            const ForgotPassword(),
            20.toSizedBoxH(),
            ContinueButton(
              text: "Continuar",
              onClicked: () => Navigator.of(context).pushReplacement(HomePage.route()),
            ),
            20.toSizedBoxH(),
            NewAccount(),
          ],
        ),
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class NewAccount extends StatelessWidget {
  const NewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ainda não tem uma conta? ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(UserRegisterPage.route()),
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
