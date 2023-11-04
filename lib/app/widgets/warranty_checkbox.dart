import 'package:gap/gap.dart';
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
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool?)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 3),
      child: Row(
        children: [
          Checkbox.adaptive(
            value: isChecked,
            onChanged: onTap,
          ),
          const Gap(
            10,
          ),
          Text(text),
        ],
      ),
    );
  }
}
