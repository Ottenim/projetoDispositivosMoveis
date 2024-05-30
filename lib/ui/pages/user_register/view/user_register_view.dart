import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/ui/pages/user_register/bloc/user_register_bloc.dart';
import 'package:barber/ui/pages/user_register/user_register.dart';
import 'package:barber/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserRegisterView extends StatelessWidget {
  const UserRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: context.read<UserRegisterBloc>().formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text(
                  'Bem vindo!',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Urbanist',
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                child: const Text(
                  'Crie sua conta',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Urbanist',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              BaseTextField(
                hint: 'Nome completo',
                validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                prefixIcon: SvgPicture.asset('assets/icons/user.svg'),
                onChanged: (value) => context.read<UserRegisterBloc>().add(UserRegisterNameChanged(value)),
              ),
              BaseTextField(
                hint: 'CPF',
                validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.number,
                inputFormatters: [MaskTextInputFormatter(mask: '###.###.###-##')],
                onChanged: (value) => context.read<UserRegisterBloc>().add(UserRegisterCpfChanged(value)),
              ),
              BaseTextField(
                hint: 'Senha',
                validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(Icons.lock_outline_rounded),
                onChanged: (value) => context.read<UserRegisterBloc>().add(UserRegisterPasswordChanged(value)),
              ),
              32.toSizedBoxH(),
              BaseButton(
                title: 'Continuar',
                onPressed: () => context.read<UserRegisterBloc>().add(UserRegisterCreate()),
              ),
              12.toSizedBoxH(),
              BaseButton(
                title: 'Voltar',
                type: ButtonType.secondary,
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
