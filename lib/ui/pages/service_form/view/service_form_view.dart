import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/ui/pages/service_form/bloc/service_form_bloc.dart';
import 'package:barber/ui/widgets/widgets.dart';
import 'package:barber/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validadores/validadores.dart';

class ServiceFormView extends StatelessWidget {
  const ServiceFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
      buildWhen: (previous, current) => previous.initState != current.initState,
      builder: (context, state) {
        if (state.initState.status == PageStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: context.read<ServiceFormBloc>().formKey,
                  child: Column(
                    children: [
                      BaseTextField(
                        hint: 'Nome do corte',
                        initialValue: state.name,
                        validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').validar(value),
                        onChanged: (value) => context.read<ServiceFormBloc>().add(ServiceFormNameChanged(value)),
                      ),
                      BaseTextField(
                        hint: 'Duração',
                        keyboardType: TextInputType.number,
                        initialValue: state.duration,
                        inputFormatters: [context.read<ServiceFormBloc>().durationMask],
                        validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').validar(value),
                        onChanged: (value) => context.read<ServiceFormBloc>().add(ServiceFormDurationChanged(value)),
                      ),
                      BlocBuilder<ServiceFormBloc, ServiceFormState>(
                        buildWhen: (previous, current) => previous.value != current.value,
                        builder: (context, state) {
                          return BaseTextField(
                            hint: 'Valor',
                            initialValue: state.value,
                            keyboardType: TextInputType.number,
                            validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').validar(value),
                            inputFormatters: [context.read<ServiceFormBloc>().valueMask],
                            onChanged: (value) => context.read<ServiceFormBloc>().add(ServiceFormValueChanged(value)),
                          );
                        },
                      ),
                      BaseTextField(
                        hint: 'Informação',
                        initialValue: state.info,
                        fieldType: FieldType.expanded,
                        onChanged: (value) => context.read<ServiceFormBloc>().add(ServiceFormInfoChanged(value)),
                      ),
                    ],
                  ),
                ),
                BaseButton(
                  title: context.read<ServiceFormBloc>().service == null ? 'Salvar' : 'Atualizar',
                  onPressed: () => context.read<ServiceFormBloc>().service == null
                      ? context.read<ServiceFormBloc>().add(ServiceFormAdd())
                      : context.read<ServiceFormBloc>().add(ServiceFormUpdate()),
                ),
                16.toSizedBoxH(),
                BaseButton(
                  title: 'Cancelar',
                  type: ButtonType.secondary,
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
