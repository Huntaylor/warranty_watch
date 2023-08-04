part of 'warranties_cubit.dart';

class WarrantiesState extends Equatable {
  const WarrantiesState();

  bool get isLoading => this is _Loading;
  bool get isReady => this is _Ready;
  bool get isError => this is _Error;

  _Loading get asLoading => this as _Loading;
  _Ready get asReady => this as _Ready;
  _Error get asError => this as _Error;

  @override
  List<Object?> get props => [];
}

class _Loading extends WarrantiesState {
  const _Loading();
}

@autoequal
@CopyWith()
class _Ready extends WarrantiesState {
  const _Ready({
    required this.warrantyInfo,
    this.expiring,
    this.remove,
  });

  final List<WarrantyInfo> warrantyInfo;
  final List<WarrantyInfo>? expiring;
  final bool? remove;

  @override
  List<Object?> get props => _$props;
}

@autoequal
class _Error extends WarrantiesState {
  const _Error({
    this.error,
  });

  final String? error;

  @override
  List<Object?> get props => _$props;
}
