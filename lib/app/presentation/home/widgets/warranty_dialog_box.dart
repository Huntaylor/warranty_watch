import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/loading/widgets/triangle_loading_indicator.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/widgets/warranty_countdown.dart';
import 'package:warranty_watch/modules/cubit/warranties/warranties_cubit.dart';

class WarrantyDialogBox extends StatelessWidget {
  const WarrantyDialogBox({
    required this.warrantyInfo,
    super.key,
  }) : super();
  final WarrantyInfo warrantyInfo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WarrantiesCubit, WarrantiesState>(
      buildWhen: (_, state) {
        return state.isReady;
      },
      builder: (context, state) {
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
                    fit: StackFit.expand,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: context.colorScheme.tertiaryContainer
                              .withOpacity(.4),
                        ),
                        child: _WarrantyImageHandler(
                          onLongPress: () {},

                          /* async {
                            final response = await Dio().get<List<int>>(
                              warrantyInfo.imageUrl!,
                              options:
                                  Options(responseType: ResponseType.bytes),
                            );
                            await ImageGallerySaver.saveImage(
                              Uint8List.fromList(response.data ?? []),
                              quality: 60,
                              name: warrantyInfo.name,
                            );
                          }, */
                          isProductImage: state.asReady.isProductImage,
                          warrantyInfo: warrantyInfo,
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
                        onPress: () {
                          context.pop();
                          // context.read<WarrantiesCubit>().swapImages(
                          //       isProductImage: true,
                          //     );
                        },
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
                            child: IconButton(
                              onPressed: () {
                                context.read<WarrantiesCubit>().swapImages(
                                      isProductImage:
                                          !state.asReady.isProductImage,
                                    );
                              },
                              icon: const Icon(
                                Icons.swap_horiz,
                              ),
                              color: context.colorScheme.onPrimary,
                            ),
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
                if (warrantyInfo.purchaseDate != null) ...[
                  Text('Purchased: ${warrantyInfo.purchaseDate!}'),
                  const Gap(5),
                ],
                if (warrantyInfo.endOfWarranty != null)
                  WarrantyCountdown.long(
                    warrantyDate: warrantyInfo.endOfWarranty!,
                  )
                else
                  Text(
                    'Lifetime Warranty',
                    style: context.textTheme.bodySmall!
                        .copyWith(color: context.colorScheme.primary),
                  ),
                const Gap(5),
                if (warrantyInfo.details != null &&
                    warrantyInfo.details!.isNotEmpty)
                  Text.rich(
                    TextSpan(
                      text: 'Description: ',
                      style: context.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                          text: warrantyInfo.details,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
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

class _WarrantyImageHandler extends StatelessWidget {
  const _WarrantyImageHandler({
    required this.warrantyInfo,
    required this.isProductImage,
    required this.onLongPress,
  });

  final bool isProductImage;
  final WarrantyInfo warrantyInfo;
  final void Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    final bool localIsProductImage;
    final bool hasImages;
    final validImage = isUrlValid(warrantyInfo.imageUrl);
    final validReceiptImage = isUrlValid(warrantyInfo.receiptImageUrl);

    final bothAvailable = validImage && validReceiptImage;

    if (bothAvailable) {
      localIsProductImage = isProductImage;
      hasImages = true;
    } else if (validImage) {
      localIsProductImage = true;
      hasImages = true;
    } else if (validReceiptImage) {
      localIsProductImage = false;
      hasImages = true;
    } else {
      hasImages = false;
      localIsProductImage = false;
    }

    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        child: hasImages
            ? Visibility(
                visible: localIsProductImage,
                replacement: imageMethod(warrantyInfo.receiptImageUrl!),
                child: imageMethod(warrantyInfo.imageUrl!),
              )
            : null,
      ),
    );
  }

  Image imageMethod(String src) {
    return Image.network(
      fit: BoxFit.contain,
      src,
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
      loadingBuilder: (context, child, loadingProgress) {
        return (loadingProgress == null)
            ? child
            : const SizedBox.expand(
                child: TriangleLoadingIndicator(),
              );
      },
    );
  }
}
