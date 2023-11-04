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
    final days = timeRemaining(warrantyDate).$2.$3;
    final months = timeRemaining(warrantyDate).$2.$2;
    final years = timeRemaining(warrantyDate).$2.$1;
    final longerText = 'Expires: ${timeRemaining(warrantyDate).$1}';
    final shorterText = timeRemaining(warrantyDate).$1;

    return Text(
      isLong ? longerText : shorterText,
      style: context.textTheme.bodySmall!.copyWith(
        color: expiringColor(
          context: context,
          years: years,
          days: days,
          months: months,
        ),
      ),
    );
  }
}

(String, (int, int, int)) timeRemaining(DateTime expiration) {
  final now = DateTime.now();
  var difference = expiration.difference(now);

  final years = difference.inDays ~/ 365;
  difference = difference - Duration(days: years * 365);

  final months = (difference.inDays % 365) ~/ 30;
  difference = difference - Duration(days: months * 30);

  final days = difference.inDays % 30;

  return (
    '${years}y ${months}m ${days}d',
    (
      years,
      months,
      days,
    ),
  );
}

Color expiringColor({
  required int years,
  required int months,
  required int days,
  required BuildContext context,
}) {
  const red = Colors.red;
  const orange = Colors.orange;
  final normal = context.colorScheme.tertiaryContainer;
  if (years >= 1 && months >= 1) {
    return normal;
  } else if (days < 30 && years == 0) {
    return red;
  } else if (months < 2 && years == 0) {
    return orange;
  } else {
    return normal;
  }
}
