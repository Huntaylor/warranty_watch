import 'package:warranty_watch/app/app_library.dart';

class WarrantyImage extends StatelessWidget {
  const WarrantyImage({
    required this.text,
    required this.onTap,
    required this.icon,
    super.key,
    this.image,
  });

  final String? image;
  final String text;
  final VoidCallback onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: (image != null)
          ? Stack(
              children: [
                Center(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image(
                      image: FileImage(File(image!)),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Transform.translate(
                      offset: const Offset(5, -5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.change_circle_rounded,
                          color: context.colorScheme.tertiaryContainer,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color:
                    context.colorScheme.tertiaryContainer.withValues(alpha: .4),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.tertiaryContainer
                        .withValues(alpha: .9),
                  ),
                  child: IconButton(
                    onPressed: onTap,
                    icon: Icon(
                      Icons.add,
                      color: context.colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
