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
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
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
                      Text(
                        appLocalizations.detailsName(warrantyInfo.name!),
                      ),
                      Text(
                        appLocalizations.purchaseDateDetails(
                          _dateFormat(warrantyInfo.purchaseDate!),
                        ),
                      ),
                      warrantyInfo.lifeTime
                          ? Text(appLocalizations.hasLifetime)
                          : Text(
                              appLocalizations.expirationDetailsDate(
                                _dateFormat(warrantyInfo.endOfWarr!),
                              ),
                              style: TextStyle(
                                color: _dateDiff(warrantyInfo.endOfWarr!)
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
