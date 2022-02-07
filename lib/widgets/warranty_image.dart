import 'package:warranty_keeper/app_library.dart';

class WarrantyImage extends StatelessWidget {
  const WarrantyImage({
    Key? key,
    this.file,
    required this.text,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final File? file;
  final String text;
  final VoidCallback onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 5, right: 5),
      child: file != null
          ? Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Image(
                      image: FileImage(file!),
                      fit: BoxFit.cover,
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
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.change_circle,
                          color: Colors.lightBlue,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade500,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        text,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      icon,
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
