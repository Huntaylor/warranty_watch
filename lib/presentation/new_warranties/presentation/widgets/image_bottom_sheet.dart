import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

class ImageBottomSheet extends StatelessWidget {
  final VoidCallback? onRecieptPhotoTap;
  final VoidCallback? onRecieptCameraTap;
  final VoidCallback? onProductCameraTap;
  final VoidCallback? onProductPhotoTap;
  const ImageBottomSheet({
    Key? key,
    this.onRecieptPhotoTap,
    this.onRecieptCameraTap,
    this.onProductCameraTap,
    this.onProductPhotoTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewWarrantyCubit, WarrantyInfo>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // context.pop();
                        Navigator.of(context).pop();
                      },
                      child: Text(context.appLocalizations.cancel),
                    ),
                    Text(context.appLocalizations.addItem),
                    const SizedBox(
                      width: 48,
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 24,
                thickness: 2,
              ),
              Flexible(
                child: state.isLoading
                    ? const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap:
                                onRecieptPhotoTap ?? onProductPhotoTap ?? () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.photo_outlined,
                                  color: Colors.orange[400],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(context.appLocalizations.photos),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: onRecieptCameraTap ??
                                onProductCameraTap ??
                                () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.green[400],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(context.appLocalizations.camera),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
