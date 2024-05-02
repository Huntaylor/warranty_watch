import 'package:marquee/marquee.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';

class WarrantyListCard extends StatelessWidget {
  const WarrantyListCard({
    required this.warrantyInfo,
    super.key,
  }) : super();

  final WarrantyInfo warrantyInfo;

  @override
  Widget build(BuildContext context) {
    final isLifetime = warrantyInfo.lifetime;
    final endDate = warrantyInfo.endOfWarranty;
    const duration = Duration(seconds: 5);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: GestureDetector(
        onTap: () => onWarrantyTap(
          warrantyInfo: warrantyInfo,
          context: context,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorScheme.primary.withOpacity(.3),
            ),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withOpacity(.1),
                offset: const Offset(
                  0,
                  4,
                ),
                blurRadius: 3,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Colors.white,
              ),
            ],
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: BoxConstraints.loose(
                  const Size(
                    150,
                    25,
                  ),
                ),
                child: Visibility(
                  replacement: Text(
                    warrantyInfo.name!,
                    style: context.textTheme.labelLarge,
                  ),
                  visible: warrantyInfo.name!.length >= 15,
                  child: Marquee(
                    text: warrantyInfo.name!,
                    style: context.textTheme.labelLarge,
                    blankSpace: 25,
                    pauseAfterRound: duration,
                    startAfter: duration,
                    showFadingOnlyWhenScrolling: false,
                    fadingEdgeEndFraction: 0.5,
                  ),
                ),
              ),
              if (isLifetime)
                Text(
                  'Lifetime Warranty',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorScheme.primary.withOpacity(.5),
                  ),
                )
              else if (isExpired(endDate!))
                Text(
                  'Expired: ${endDate.month}/${endDate.day}/${endDate.year}',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorScheme.error.withOpacity(.5),
                  ),
                )
              else
                Text(
                  'Expires: ${endDate.month}/${endDate.day}/${endDate.year}',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorScheme.primary.withOpacity(.5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
