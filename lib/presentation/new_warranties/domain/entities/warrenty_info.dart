import 'package:warranty_keeper/app_library.dart';

class WarrantyInfo extends Equatable {
  final Key key;
  final String? name;
  final DateTime? purchaseDate;
  final String? warrWebsite;
  final DateTime? endOfWarr;
  final String? details;
  final File? image;
  final File? receiptImage;
  final bool lifeTime;
  WarrantyInfo({
    this.name,
    this.purchaseDate,
    this.warrWebsite,
    this.endOfWarr,
    this.details,
    this.image,
    this.receiptImage,
    this.lifeTime = false,
  }) : key = UniqueKey();

  @override
  List<Object?> get props => [
        name,
        purchaseDate,
        endOfWarr,
        warrWebsite,
        details,
        image,
        receiptImage,
        lifeTime,
        key,
      ];

  WarrantyInfo copyWith({
    String? name,
    DateTime? purchaseDate,
    DateTime? endOfWarr,
    String? warrWebsite,
    String? details,
    File? image,
    File? receiptImage,
    bool? lifeTime,
    Key? key,
  }) {
    return WarrantyInfo(
      name: name ?? this.name,
      purchaseDate: purchaseDate ?? DateTime.now(),
      endOfWarr: endOfWarr ?? this.endOfWarr,
      warrWebsite: warrWebsite ?? this.warrWebsite,
      details: details ?? this.details,
      image: image ?? this.image,
      receiptImage: receiptImage ?? this.receiptImage,
      lifeTime: lifeTime ?? this.lifeTime,
    );
  }

  bool canSave() {
    if (name == null) return false;
    if (name!.isEmpty) return false;
    if (purchaseDate == null) return false;
    if (warrWebsite == null) return false;
    if (image == null) return false;
    if (endOfWarr == null && lifeTime != true) return false;
    return true;
  }
}
