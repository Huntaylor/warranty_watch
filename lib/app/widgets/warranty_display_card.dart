import 'package:marquee/marquee.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/loading/widgets/triangle_loading_indicator.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/presentation/warranty_details/presentation/warranty_details_view.dart';
import 'package:warranty_watch/app/widgets/warranty_countdown.dart';

class WarrantyDisplayCard extends StatelessWidget {
  const WarrantyDisplayCard({
    required this.warrantyInfo,
    required this.onSelect,
    super.key,
  }) : super();
  final WarrantyInfo warrantyInfo;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(seconds: 5);
    return GestureDetector(
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          top: 10,
          bottom: 10,
          left: 3,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withOpacity(.1),
                offset: const Offset(
                  0,
                  3,
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
          child: SizedBox(
            height: 200,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: context.colorScheme.tertiaryContainer
                              .withOpacity(.4),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: isUrlValid(warrantyInfo.imageUrl)
                            ? Image.network(
                                warrantyInfo.imageUrl!,
                                fit: BoxFit.contain,
                                frameBuilder: (
                                  context,
                                  child,
                                  frame,
                                  wasSynchronouslyLoaded,
                                ) {
                                  if (wasSynchronouslyLoaded) {
                                    return child;
                                  }
                                  return AnimatedOpacity(
                                    opacity: frame == null ? 0 : 1,
                                    duration: const Duration(seconds: 3),
                                    curve: Curves.easeOut,
                                    child: child,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  return (loadingProgress == null)
                                      ? child
                                      : const SizedBox.expand(
                                          child: TriangleLoadingIndicator(),
                                        );
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Visibility(
                      replacement: Text(
                        warrantyInfo.name!,
                        style: context.textTheme.labelLarge,
                      ),
                      visible: warrantyInfo.name!.length >= 18,
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
                  const SizedBox(
                    height: 5,
                  ),
                  WarrantyCountdown.onlyTime(
                    warrantyDate: warrantyInfo.endOfWarranty!,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
