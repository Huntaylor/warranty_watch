import 'package:warranty_watch/app/app_library.dart';

class PasswordRequirementWidget extends StatelessWidget {
  const PasswordRequirementWidget({
    required this.isTrue,
    required this.title,
    super.key,
  });
  final bool isTrue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isTrue)
          Icon(
            Icons.check_circle_outline,
            color: context.colorScheme.primary,
          )
        else
          Icon(
            Icons.highlight_remove_outlined,
            color: context.colorScheme.error,
          ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
        ),
      ],
    );
  }
}
