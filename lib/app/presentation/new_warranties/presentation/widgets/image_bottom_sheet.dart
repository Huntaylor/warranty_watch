import 'package:warranty_watch/app/app_library.dart';

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({
    super.key,
    this.onReceiptPhotoTap,
    this.onReceiptCameraTap,
    this.onProductCameraTap,
    this.onProductPhotoTap,
  });
  final VoidCallback? onReceiptPhotoTap;
  final VoidCallback? onReceiptCameraTap;
  final VoidCallback? onProductCameraTap;
  final VoidCallback? onProductPhotoTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
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
                    context.pop();
                  },
                  child: Text(context.l10n.cancel),
                ),
                Text(context.l10n.addItem),
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
            child: /*  state.warrantyState == WarrantyState.loadingImage
                ? const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                :  */
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onReceiptPhotoTap ?? onProductPhotoTap ?? () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_outlined,
                        color: Colors.orange[400],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(context.l10n.photos),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: onReceiptCameraTap ?? onProductCameraTap ?? () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.green[400],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(context.l10n.camera),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
