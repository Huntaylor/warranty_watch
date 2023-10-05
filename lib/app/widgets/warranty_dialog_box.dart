import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';

class WarrantyDialogBox extends StatelessWidget {
  const WarrantyDialogBox({
    required this.warrantyInfo,
    super.key,
  }) : super();
  final WarrantyInfo warrantyInfo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: context.colorScheme.tertiaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              warrantyInfo.name!,
              style: context.textTheme.labelLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              warrantyInfo.endOfWarranty!.toString(),
              style: context.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
