import 'package:warranty_keeper/app_library.dart';

class WarrantyCheckBox extends StatelessWidget {
  final String text;
  final bool isChecked;
  final VoidCallback onTap;
  const WarrantyCheckBox({
    Key? key,
    required this.text,
    required this.onTap,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 3),
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
            Text(text)
          ],
        ),
      ),
    );
  }
}
