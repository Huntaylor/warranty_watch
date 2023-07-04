part of 'home_cubit.dart';

@CopyWith()
class HomeState extends Cubit<HomeState> {
  final List<WarrantyInfo> expiringList;

  HomeState(
    this.expiringList,
  ) : super(HomeState(expiringList));
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super([]);
}
