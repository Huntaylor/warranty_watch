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
    final appLocalizations = context.appLocalizations;
    return GestureDetector(
      onTap: onSelect,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(),
        ),
        color: context.colorScheme.primaryContainer,
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Row(
          children: [
            if (warrantyInfo.imageUrl != null &&
                warrantyInfo.imageUrl!.isNotEmpty)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.colorScheme.onSecondaryContainer,
                  ),
                  clipBehavior: Clip.antiAlias,
                  constraints: const BoxConstraints(
                    maxHeight: 75,
                    minHeight: 50,
                  ),
                  child: Image.network(
                    warrantyInfo.imageUrl!,
                    fit: BoxFit.fitHeight,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.detailsName(warrantyInfo.name!),
                    ),
                    if (warrantyInfo.purchaseDate != null)
                      Text(
                        appLocalizations.purchaseDateDetails(
                          _dateFormat(warrantyInfo.purchaseDate!),
                        ),
                      ),
                    warrantyInfo.lifeTime
                        ? Text(appLocalizations.hasLifetime)
                        : Text(
                            appLocalizations.expirationDetailsDate(
                              _dateFormat(warrantyInfo.endOfWarranty!),
                            ),
                            style: TextStyle(
                              color: _dateDiff(warrantyInfo.endOfWarranty!)
                                  ? Colors.red
                                  : null,
                            ),
                          ),
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
                    child: Text(appLocalizations.edit),
                  ),
                  PopupMenuItem(
                    onTap: onRemove,
                    child: Text(appLocalizations.remove),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_dateDiff(DateTime date) {
  if (date.difference(DateTime.now()).inDays < 7) {
    return true;
  } else {
    return false;
  }
}

String _dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
