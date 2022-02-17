import 'package:warranty_keeper/app_library.dart';

class WarrantyImages {
  final bool isPrimary;
  final File image;
  WarrantyImages({
    required this.isPrimary,
    required this.image,
  });

  List<Object?> get props => [
        image,
        isPrimary,
      ];

  WarrantyImages copyWith({
    bool? isPrimary,
    File? image,
  }) {
    return WarrantyImages(
      isPrimary: isPrimary ?? this.isPrimary,
      image: image ?? this.image,
    );
  }
}
