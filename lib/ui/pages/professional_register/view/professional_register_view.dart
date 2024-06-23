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
            onRefresh: () =>
                context.read<ProfessionalRegisterBloc>().add(UsersFetch()),
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
    return BaseCard(
        onTap: () {},
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffFFF112)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(user.name!),
                    Checkbox(
                      checkColor: const Color(0xffFFF112),
                      value: user.userCategory == UserCategory.barber,
                      onChanged: (bool? value) async {
                        context
                            .read<ProfessionalRegisterBloc>()
                            .add(UserCategoryChanged(user, user.userCategory!));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
