import 'package:warranty_keeper/app_library.dart';

class PasswordRequirementWidget extends StatelessWidget {
  final bool isTrue;
  final String title;
  const PasswordRequirementWidget({
    Key? key,
    required this.isTrue,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isTrue
            ? Icon(
                Icons.check_circle_outline,
                color: context.colorScheme.primary,
              )
            : Icon(
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
