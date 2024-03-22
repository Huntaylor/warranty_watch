import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';

class CurrentWidgetCard extends StatelessWidget {
  const CurrentWidgetCard({
    required this.warrantyInfo,
    required this.onEdit,
    required this.onRemove,
    required this.onSelect,
    super.key,
  });
  final WarrantyInfo warrantyInfo;
  final VoidCallback onEdit;
  final VoidCallback onRemove;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                    loadingBuilder: (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
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
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.detailsName(warrantyInfo.name!),
                    ),
                    if (warrantyInfo.purchaseDate != null)
                      Text(
                        l10n.purchaseDateDetails(
                          dateFormat(warrantyInfo.purchaseDate!),
                        ),
                      ),
                    if (warrantyInfo.lifetime)
                      Text(l10n.hasLifetime)
                    else
                      Text(
                        l10n.expirationDetailsDate(
                          dateFormat(warrantyInfo.endOfWarranty!),
                        ),
                        style: TextStyle(
                          color: dateDiff(warrantyInfo.endOfWarranty!)
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
                  PopupMenuItem<Widget>(
                    onTap: onEdit,
                    child: Text(l10n.edit),
                  ),
                  PopupMenuItem<Widget>(
                    onTap: onRemove,
                    child: Text(l10n.remove),
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
