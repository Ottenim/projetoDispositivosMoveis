import 'package:barber/models/user.dart';
import 'package:barber/ui/pages/professional_register/bloc/professional_register_bloc.dart';
import 'package:barber/ui/widgets/base_card.dart';
import 'package:barber/ui/widgets/base_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalRegisterView extends StatelessWidget {
  const ProfessionalRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfessionalRegisterBloc, ProfessionalRegisterState>(
        buildWhen: (previous, current) => previous.state != current.state,
        builder: (context, state) {
          return BaseList(
            items: state.users,
            state: state.state,
            onRefresh: () => context.read<ProfessionalRegisterBloc>().add(UsersFetch()),
            itemBuilder: (context, item) => ProfessionalCard(item),
          );
        });
  }
}

class ProfessionalCard extends StatelessWidget {
  const ProfessionalCard(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfessionalRegisterBloc, ProfessionalRegisterState>(
      buildWhen: (previous, current) => previous.users != current.users,
      builder: (context, state) {
        return BaseCard(
          onTap: () => context
              .read<ProfessionalRegisterBloc>()
              .add(UserCategoryChanged(user, user.userCategory == UserCategory.client ? UserCategory.barber : UserCategory.client)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(user.name!),
                      Checkbox(
                        checkColor: const Color(0xffFFF112),
                        value: state.users.firstWhere((element) => element.id == user.id).userCategory == UserCategory.barber,
                        onChanged: (bool? value) {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
