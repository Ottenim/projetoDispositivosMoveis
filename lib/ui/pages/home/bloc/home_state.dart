part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.state = const PageState(PageStatus.none),
  });

  final PageState state;

  HomeState copyWith({
    PageState? state,
  }) {
    return HomeState(
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [state];
}
