import 'package:flutter/material.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';

class WarrantyDisplayCard extends StatelessWidget {
  const WarrantyDisplayCard({
    required this.warrantyInfo,
    required this.onSelect,
    super.key,
  }) : super();
  final WarrantyInfo warrantyInfo;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Card(
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              Container(),
              Text(warrantyInfo.name!),
              Text(
                dateFormat(warrantyInfo.endOfWarranty!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
