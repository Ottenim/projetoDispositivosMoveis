import 'package:barber/infra/extensions/integer.dart';
import 'package:barber/models/models.dart';
import 'package:barber/ui/pages/schedule/bloc/schedule_bloc.dart';
import 'package:barber/ui/widgets/base_button.dart';
import 'package:barber/ui/widgets/base_date_picker.dart';
import 'package:barber/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen: (previous, current) => previous.state != current.state,
      builder: (context, state) {
        if (state.state.status == PageStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: context.read<ScheduleBloc>().formKey,
                  child: Column(
                    children: [
                      Subtitle("Selecione o profissional"),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: state.professionals.map((e) => ProfessionalSelection(e)).toList(),
                        ),
                      ),
                      SizedBox(height: 15),
                      DateTimeSelector(),
                      TimePicker(),
                      SizedBox(height: 15),
                      ServicePicker(state.services),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              BaseButton(
                title: 'Continuar',
                onPressed: () => context.read<ScheduleBloc>().add(ScheduleSave()),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfessionalSelection extends StatelessWidget {
  const ProfessionalSelection(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        buildWhen: (previous, current) => previous.selectedProfessional != current.selectedProfessional,
        builder: (context, state) {
          return GestureDetector(
            onTap: () => context.read<ScheduleBloc>().add(ScheduleProfessionalChanged(user)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: user.id == state.selectedProfessional?.id ? Color(0xFFFFF112) : Colors.transparent,
                    child: user.imageUrl?.isNotEmpty == true
                        ? CircleAvatar(
                            radius: 33,
                            backgroundImage: NetworkImage(user.imageUrl ?? ''),
                          )
                        : Icon(Icons.camera_alt, color: Colors.black),
                  ),
                ),
                SizedBox(height: 8),
                Text(user.name ?? '', style: TextStyle(color: Colors.white)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DateTimeSelector extends StatelessWidget {
  const DateTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Subtitle('Selecione a data'),
        SizedBox(height: 10),
        BaseDatePicker(
          hint: '00/00/0000',
          validator: (value) => value == null
              ? 'Campo Obrigatório'
              : value.isBefore(DateTime.now().copyWith(second: 0, microsecond: 0, millisecond: 0, minute: 0, hour: 0))
                  ? 'Data deve ser maior que atual'
                  : null,
          onChanged: (value) => context.read<ScheduleBloc>().add(ScheduleDateChanged(value)),
        )
      ],
    );
  }
}

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen: (previous, current) => previous.selectedHour != current.selectedHour,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Subtitle('Selecione a hora'),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
                value: state.selectedHour,
                hint: Text('Selecione uma hora'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF333333),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                validator: (value) => value == null ? 'Campo obrigatório' : null,
                dropdownColor: Color(0xFF333333),
                icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                items: state.availableHours
                    .map((time) => DropdownMenuItem<String>(
                          value: time,
                          child: Text(time, style: TextStyle(color: Colors.white, fontSize: 14)),
                        ))
                    .toList(),
                onChanged: (time) => context.read<ScheduleBloc>().add(ScheduleHourChanged(time))),
          ],
        );
      },
    );
  }
}

class ServicePicker extends StatelessWidget {
  const ServicePicker(this.services, {super.key});

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen: (previous, current) => previous.selectedService != current.selectedService,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Subtitle('Selecione o serviço'),
            SizedBox(height: 10),
            DropdownButtonFormField<Service>(
              hint: Text('Selecione um serviço'),
              value: state.selectedService,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF333333),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              validator: (value) => value == null ? 'Campo Obrigatório' : null,
              dropdownColor: Color(0xFF333333),
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              items: services
                  .map((service) => DropdownMenuItem<Service>(
                        value: service,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF112),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'R\$${service.value}',
                                style: TextStyle(color: Colors.black, fontSize: 12),
                              ),
                            ),
                            15.toSizedBoxW(),
                            Text(service.name ?? '', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (service) => context.read<ScheduleBloc>().add(ScheduleServiceChanged(service)),
            ),
          ],
        );
      },
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle(this.subtitle, {super.key});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          subtitle,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        10.toSizedBoxW(),
        Expanded(
          child: Container(
            height: 1,
            color: Color(0xffFFF112),
          ),
        ),
      ],
    );
  }
}
