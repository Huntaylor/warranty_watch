import 'package:warranty_watch/app/app_library.dart';

class WarrantyCheckBox extends StatelessWidget {
  const WarrantyCheckBox({
    required this.text,
    required this.onTap,
    required this.isChecked,
    super.key,
  });
  final String text;
  final bool isChecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 3),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
