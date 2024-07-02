import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/models/models.dart';
import 'package:barber/ui/pages/photo_integratione/photo.dart';
import 'package:barber/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:barber/ui/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validadores/Validador.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(this.user, {Key? key}) : super(key: key);

  final User user;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  XFile? _selectedImage;
  bool _isUploading = false;

  void _handleImageSelected(XFile? image) {
    if (image != null) {
      context.read<ProfileBloc>().add(ProfileImageChanged(image.path));
    } else {
      context.read<ProfileBloc>().add(const ProfileImageChanged(''));
    }
    setState(() {
      _selectedImage = image;
    });
  }

  void _handleSaveButtonPressed() async {
    context.read<ProfileBloc>().add(ProfileSaveChanges());
  }

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
                    Photo(
                      onImageSelected: _handleImageSelected,
                      initialImage: widget.user.imageUrl ?? '',
                    ),
                    BaseTextField(
                      initialValue: widget.user.name,
                      prefixIcon: SvgPicture.asset('assets/icons/user.svg'),
                      validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').validar(value),
                      onChanged: (value) => context.read<ProfileBloc>().add(ProfileNameChanged(value)),
                    ),
                    BaseTextField(
                      initialValue: widget.user.cpf,
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
          _isUploading ? CircularProgressIndicator() : SizedBox.shrink(),
          BaseButton(
            title: 'Salvar',
            onPressed: _handleSaveButtonPressed,
          ),
          16.toSizedBoxH(),
          BaseButton(
            title: 'Deletar minha conta',
            type: ButtonType.secondary,
            onPressed: () => context.read<ProfileBloc>().add(ProfileDeleteAccount()),
          ),
        ],
      ),
    );
  }
}
