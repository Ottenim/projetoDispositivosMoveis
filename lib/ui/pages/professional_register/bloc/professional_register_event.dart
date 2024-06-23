part of 'professional_register_bloc.dart';

class ProfessionalRegisterEvent extends Equatable {
  const ProfessionalRegisterEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserCategoryChanged extends ProfessionalRegisterEvent {
  const UserCategoryChanged(this.user, this.userCategory);

  final User user;
  final UserCategory userCategory;
}

class UsersFetch extends ProfessionalRegisterEvent {}
