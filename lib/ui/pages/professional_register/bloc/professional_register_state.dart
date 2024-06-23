part of 'professional_register_bloc.dart';

class ProfessionalRegisterState extends Equatable {
  const ProfessionalRegisterState({
    this.users = const [],
    this.state = const PageState(PageStatus.none),
    this.itemState = const PageState(PageStatus.none),
  });

  final List<User> users;
  final PageState state;
  final PageState itemState;

  ProfessionalRegisterState copyWith({
    List<User>? users,
    PageState? state,
    PageState? itemState,
  }) {
    return ProfessionalRegisterState(
      users: users ?? this.users,
      state: state ?? this.state,
      itemState: itemState ?? this.itemState,
    );
  }

  @override
  List<Object?> get props => [users, state, itemState];
}
