import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/models/models.dart';
import 'package:barber/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:barber/ui/pages/profile/profile.dart';
import 'package:barber/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:validadores/Validador.dart';

class ProfileView extends StatelessWidget {
  const ProfileView(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12).add(EdgeInsets.only(bottom: 36)),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: context.read<ProfileBloc>().globalKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    BaseTextField(
                      initialValue: user.name,
                      prefixIcon: SvgPicture.asset('assets/icons/user.svg'),
                      validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').validar(value),
                      onChanged: (value) => context.read<ProfileBloc>().add(ProfileNameChanged(value)),
                    ),
                    BaseTextField(
                      initialValue: user.cpf,
                      prefixIcon: Image.asset('assets/images/profile.png', color: Colors.white),
                      validator: (value) =>
                          Validador().add(Validar.CPF, msg: 'Cpf inválido').add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').validar(value),
                      onChanged: (value) => context.read<ProfileBloc>().add(ProfileCpfChanged(value)),
                    ),
                    BaseTextField(
                      hint: 'Nova senha',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').validar(value),
                      onChanged: (value) => context.read<ProfileBloc>().add(ProfilePasswordChanged(value)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BaseButton(
            title: 'Salvar',
            onPressed: () => context.read<ProfileBloc>().add(ProfileSaveChanges()),
          ),
          16.toSizedBoxH(),
          BaseButton(
            title: 'Deletar minha conta',
            type: ButtonType.secondary,
            onPressed: () => context.read<ProfileBloc>().add(ProfileDeleteAccount()),
          )
        ],
      ),
    );
  }
}
