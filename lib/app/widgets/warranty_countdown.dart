import 'package:warranty_watch/app/app_library.dart';

class WarrantyCountdown extends StatelessWidget {
  const WarrantyCountdown({
    required this.warrantyDate,
    required this.isLong,
    super.key,
  }) : super();

  const WarrantyCountdown.onlyTime({
    required this.warrantyDate,
    super.key,
  }) : isLong = false;

  const WarrantyCountdown.long({
    required this.warrantyDate,
    super.key,
  }) : isLong = true;

  final DateTime warrantyDate;
  final bool isLong;

  @override
  Widget build(BuildContext context) {
    final longerText = 'Expires: ${timeRemaining(warrantyDate).$1}';
    final shorterText = timeRemaining(warrantyDate).$1;

    return Text(
      isLong ? longerText : shorterText,
      style: context.textTheme.bodySmall!.copyWith(
        color: expiringColor(
          normalColor: context.colorScheme.primary,
          date: warrantyDate,
        ),
      ),
    );
  }
}
