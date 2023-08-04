part of 'warranty_cubit.dart';

abstract class WarrantyState extends Equatable {
  const WarrantyState();

  bool get isError => this is _Error;
  bool get isLoading => this is _Loading;
  bool get isReady => this is _Ready;

  _Ready get asReady => this as _Ready;
  _Error get asError => this as _Error;
  _Loading get asLoading => this as _Loading;

  @override
  List<Object?> get props => [];
}

class _Loading extends WarrantyState {
  const _Loading();
}

class _Error extends WarrantyState {
  const _Error();
}

@autoequal
@CopyWith()
class _Ready extends WarrantyState {
  final WarrantyInfo warrantyInfo;
  const _Ready({required this.warrantyInfo});

  @override
  List<Object?> get props => _$props;
}
