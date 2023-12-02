import 'package:jiffy/jiffy.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/home/widgets/warranty_dialog_box.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/modules/cubit/warranties/warranties_cubit.dart';

bool dateDiff(DateTime date) {
  if (date.difference(DateTime.now()).inDays < 7) {
    return true;
  } else {
    return false;
  }
}

String dateFormat(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}

String expired(DateTime expirationDate) {
  final jiffyExpirationDate = Jiffy.parseFromDateTime(expirationDate);
  final expireTime = Jiffy.now().from(jiffyExpirationDate);

  return expireTime;
}

String countDown(DateTime expirationDate) {
  final expireTime = Jiffy.parseFromDateTime(expirationDate).fromNow();

  return expireTime;
}

bool isExpired(DateTime expirationDate) =>
    countDown(expirationDate).endsWith('ago');

bool isUrlValid(String? url) {
  if (url == null) return false;
  return Uri.parse(url).isAbsolute;
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
  required DateTime date,
  required Color normalColor,
}) {
  final years = timeRemaining(date).$2.$1;
  final days = timeRemaining(date).$2.$3;
  final months = timeRemaining(date).$2.$2;

  const red = Colors.red;
  const orange = Colors.orange;
  final normal = normalColor;
  if (years >= 1 && months >= 1) {
    return normal;
  } else if (days < 30 && years == 0 && months == 0) {
    return red;
  } else if (months < 2 && years == 0) {
    return orange;
  } else {
    return normal;
  }
}

Future<void> onWarrantyTap({
  required WarrantyInfo warrantyInfo,
  required BuildContext context,
}) async {
  context.read<WarrantiesCubit>().swapImages(
        isProductImage: true,
      );
  return showDialog(
    context: context,
    builder: (context) => WarrantyDialogBox(
      warrantyInfo: warrantyInfo,
    ),
  );
}
