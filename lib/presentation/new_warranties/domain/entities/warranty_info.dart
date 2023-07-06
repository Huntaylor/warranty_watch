import 'package:warranty_keeper/app_library.dart';

class WarrantyInfo extends Equatable {
  final Key key;
  final String? name;
  final DateTime? purchaseDate;
  final String? warrWebsite;
  final DateTime? endOfWarr;
  final DateTime? reminderDate;
  final String? details;
  final List<File>? imagesList;
  final File? image;
  final File? receiptImage;
  final bool lifeTime;
  final bool isEditing;
  final bool wantsReminders;
  WarrantyInfo({
    this.name,
    this.purchaseDate,
    this.reminderDate,
    this.warrWebsite,
    this.endOfWarr,
    this.details,
    this.imagesList,
    this.image,
    this.receiptImage,
    this.lifeTime = false,
    this.isEditing = false,
    this.wantsReminders = false,
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
        wantsReminders,
        reminderDate,
      ];

  WarrantyInfo copyWith({
    List<File>? imagesList,
    String? name,
    DateTime? purchaseDate,
    DateTime? endOfWarr,
    DateTime? reminderDate,
    String? warrWebsite,
    String? details,
    File? image,
    File? receiptImage,
    bool? lifeTime,
    bool? isEditing,
    bool? wantsReminders,
  }) {
    return WarrantyInfo._(
      reminderDate: reminderDate ?? this.reminderDate,
      wantsReminders: wantsReminders ?? this.wantsReminders,
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

  // factory WarrantyInfo.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return WarrantyInfo(
  //     name: data?['name'],
  //     imagesList: data?['imagesList'],
  //     purchaseDate: data?['purchaseDate'],
  //     endOfWarr: data?['endOfWarr'],
  //     reminderDate: data?['reminderDate'],
  //     warrWebsite: data?['warrWebsite'],
  //     details: data?['details'],
  //     image: data?['image'],
  //     receiptImage: data?['receiptImage'],
  //     lifeTime: data?['lifeTime'],
  //     isEditing: data?['isEditing'],
  //     wantsReminders: data?['wantsReminders'],
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (name != null) "name": name,
  //     if (imagesList != null) "imagesList": imagesList,
  //     if (purchaseDate != null) "purchaseDate": purchaseDate,
  //     if (endOfWarr != null) "endOfWarr": endOfWarr,
  //     if (reminderDate != null) "reminderDate": reminderDate,
  //     if (warrWebsite != null) "warrWebsite": warrWebsite,
  //     if (details != null) "details": details,
  //     if (image != null) "image": image,
  //     if (receiptImage != null) "receiptImage": receiptImage,
  //     "lifeTime": lifeTime,
  //     "isEditing": isEditing,
  //     "wantsReminders": wantsReminders,
  //   };
  // }

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
    this.reminderDate,
    this.imagesList,
    this.name,
    this.purchaseDate,
    this.warrWebsite,
    this.endOfWarr,
    this.details,
    this.image,
    this.receiptImage,
    required this.lifeTime,
    required this.isEditing,
    required this.key,
    required this.wantsReminders,
  });
}
