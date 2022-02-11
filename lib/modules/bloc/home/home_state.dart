part of 'home_bloc.dart';

@immutable
abstract class HomeViewState {}

class InitialState extends HomeViewState {
  InitialState();

  List<Object?> get props => [];

  InitialState copyWith() {
    return InitialState();
  }
}

class NewWarrInProgress extends HomeViewState {
  final String routeName;
  NewWarrInProgress({
    required this.routeName,
  });

  List<Object?> get props => [];

  NewWarrInProgress copyWith() {
    return NewWarrInProgress(routeName: routeName);
  }
}
