import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/widgets/warranty_countdown.dart';

class WarrantyDialogBox extends StatelessWidget {
  const WarrantyDialogBox({
    required this.warrantyInfo,
    super.key,
  }) : super();
  final WarrantyInfo warrantyInfo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 320,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color:
                          context.colorScheme.tertiaryContainer.withOpacity(.4),
                    ),
                  ),
                  DialogButton(
                    alignemnt: Alignment.topLeft,
                    onPress: () {},
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 13,
                    ),
                    child: Text(
                      'Edit',
                      style: context.textTheme.bodySmall!
                          .copyWith(color: context.colorScheme.onPrimary),
                    ),
                  ),
                  DialogButton(
                    alignemnt: Alignment.topRight,
                    padding: const EdgeInsets.all(3),
                    onPress: context.pop,
                    child: Icon(
                      Icons.close,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(
              10,
            ),
            Text(
              warrantyInfo.name!,
              style: context.textTheme.titleLarge,
            ),
            const Gap(
              5,
            ),
            WarrantyCountdown.long(warrantyDate: warrantyInfo.endOfWarranty!),
          ],
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    required this.onPress,
    required this.child,
    required this.alignemnt,
    this.padding,
    super.key,
  });

  final void Function() onPress;
  final Widget child;
  final AlignmentGeometry alignemnt;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: alignemnt,
        child: GestureDetector(
          onTap: onPress,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
