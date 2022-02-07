part of 'home_view_bloc.dart';

@immutable
abstract class HomeViewEvent {}

class CurrentWarrsPressed extends HomeViewEvent {
  CurrentWarrsPressed();
  List<Object> get props => [];
}

class AddNewWarrPressed extends HomeViewEvent {
  final String routeName;
  AddNewWarrPressed({
    required this.routeName,
  });
  List<Object> get props => [routeName];
}
