import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

class CurrentWidgetCard extends StatelessWidget {
  final WarrantyInfo warrantyInfo;
  final VoidCallback onEdit;
  final VoidCallback onRemove;
  final VoidCallback onSelect;

  const CurrentWidgetCard({
    Key? key,
    required this.warrantyInfo,
    required this.onEdit,
    required this.onRemove,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.lightBlue,
            ),
          ),
          child: Row(
            children: [
              Flexible(
                child: SizedBox(
                  child: Image.file(warrantyInfo.image!),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product: ${warrantyInfo.name}'),
                      Text(
                          'Purchase Date: ${_dateFormat(warrantyInfo.purchaseDate!)}'),
                      warrantyInfo.lifeTime
                          ? const Text('Has Lifetime Warranty')
                          : Text(
                              'Expiration Date: ${_dateFormat(warrantyInfo.endOfWarr!)}')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: PopupMenuButton(
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      onTap: onEdit,
                      child: const Text('Edit'),
                    ),
                    PopupMenuItem(
                      onTap: onRemove,
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
