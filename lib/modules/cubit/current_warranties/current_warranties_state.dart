part of 'current_warranties_cubit.dart';

class CurrentWarrantiesState extends Equatable {
  const CurrentWarrantiesState();

  bool get isReady => this is _Ready;
  bool get isLoading => this is _Loading;

  _Ready get asReady => this as _Ready;

  @override
  List<Object?> get props => [];
}

@autoequal
@CopyWith()
class _Ready extends CurrentWarrantiesState {
  const _Ready({
    required this.warrantyInfo,
    required this.expiring,
    required this.remove,
  });

  final List<WarrantyInfo> warrantyInfo;
  final List<WarrantyInfo> expiring;
  final bool remove;

  @override
  List<Object?> get props => _$props;
}

class _Loading extends CurrentWarrantiesState {
  const _Loading() : super();
}
