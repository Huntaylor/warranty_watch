import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_image_model.dart';

class WarrantyInfo extends Equatable {
  final Key key;
  final String? name;
  final DateTime? purchaseDate;
  final String? warrWebsite;
  final DateTime? endOfWarr;
  final String? details;
  final List<WarrantyImages>? imagesList;
  final File? image;
  final File? receiptImage;
  final bool lifeTime;
  final bool isEditing;
  WarrantyInfo({
    this.name,
    this.purchaseDate,
    this.warrWebsite,
    this.endOfWarr,
    this.details,
    this.imagesList,
    this.image,
    this.receiptImage,
    this.lifeTime = false,
    this.isEditing = false,
  }) : key = UniqueKey();

  @override
  List<Object?> get props => [
        imagesList,
        name,
        purchaseDate,
        endOfWarr,
        warrWebsite,
        details,
        image,
        receiptImage,
        lifeTime,
        isEditing,
        key,
      ];

  WarrantyInfo copyWith({
    List<WarrantyImages>? imagesList,
    String? name,
    DateTime? purchaseDate,
    DateTime? endOfWarr,
    String? warrWebsite,
    String? details,
    File? image,
    File? receiptImage,
    bool? lifeTime,
    bool? isEditing,
  }) {
    return WarrantyInfo._(
      imagesList: imagesList ?? this.imagesList,
      isEditing: isEditing ?? this.isEditing,
      key: key,
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
    if (warrWebsite == 'https://' || warrWebsite == null) return false;
    if (image == null) return false;
    if (endOfWarr == null && lifeTime != true) return false;
    return true;
  }

  const WarrantyInfo._({
    this.imagesList,
    required this.isEditing,
    required this.key,
    this.name,
    this.purchaseDate,
    this.warrWebsite,
    this.endOfWarr,
    this.details,
    this.image,
    this.receiptImage,
    required this.lifeTime,
  });
}
