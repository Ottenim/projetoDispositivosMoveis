import 'package:barber/models/models.dart';
import 'package:barber/ui/pages/services/bloc/service_bloc.dart';
import 'package:barber/ui/widgets/base_card.dart';
import 'package:barber/ui/widgets/base_label_data.dart';
import 'package:barber/ui/widgets/base_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceView extends StatelessWidget {
  const ServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(
      buildWhen: (previous, current) => previous.state != current.state,
      builder: (context, state) {
        return BaseList<Service>(
          items: state.services,
          state: state.state,
          onRefresh: () => context.read<ServiceBloc>().add(ServiceFetch()),
          itemBuilder: (context, item) => ServiceCard(item),
        );
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard(this.service);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: () => context.read<ServiceBloc>().add(ServiceItemTapped(service)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Color(0xffFFF112)),
            child: SvgPicture.asset('assets/icons/scissors.svg'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.name ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                BaseLabelData(label: 'Duração', data: '${service.duration} minutos'),
                BaseLabelData(label: 'Valor', data: 'R\$ ${service.value?.toStringAsFixed(2).replaceFirst('.', ',')}'),
                Text(
                  (service.info == null || service.info?.isEmpty == true ? 'n/d' : service.info) ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
