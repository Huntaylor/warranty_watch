import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/loading/widgets/triangle_loading_indicator.dart';
import 'package:warranty_watch/app/widgets/sign_in_options_icons.dart';

enum AccountOption { apple, google, email, none }

class WarrantyElevatedButton extends StatelessWidget {
  const WarrantyElevatedButton({
    required this.onPressed,
    required this.text,
    required this.isEnabled,
    required this.isLoading,
    super.key,
    this.padding,
  }) : accountOption = AccountOption.none;

  const WarrantyElevatedButton.general({
    required this.onPressed,
    required this.text,
    required this.isEnabled,
    super.key,
    this.padding,
  })  : isLoading = false,
        accountOption = AccountOption.none;

  const WarrantyElevatedButton.loading({
    required this.onPressed,
    required this.text,
    required this.isLoading,
    required this.isEnabled,
    super.key,
    this.padding,
  }) : accountOption = AccountOption.none;

  const WarrantyElevatedButton.signInOption({
    required this.onPressed,
    required this.isLoading,
    required this.isEnabled,
    required this.accountOption,
    super.key,
    this.padding,
  }) : text = '';
  final VoidCallback onPressed;
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final AccountOption accountOption;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: accountOption != AccountOption.none
                ? context.colorScheme.tertiaryContainer
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
          onPressed: isEnabled
              ? isLoading
                  ? null
                  : onPressed
              : null,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 100),
            child: SizedBox(
              height: 45,
              child: isLoading
                  ? Transform.scale(
                      scale: 0.5,
                      child: const TriangleLoadingIndicator(),
                    )
                  : accountOption == AccountOption.none
                      ? Center(
                          child: Text(
                            text,
                          ),
                        )
                      : _getOption(accountOption, context),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _getOption(AccountOption accountOption, BuildContext context) {
    Widget defaultWidget(
      IconData icon,
      String name,
    ) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: context.colorScheme.onTertiaryContainer,
          ),
          Text(
            'Continue with $name',
            style: context.textTheme.titleSmall,
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      );
    }

    return switch (accountOption) {
      AccountOption.apple => defaultWidget(SignInOptions.apple, 'Apple'),
      AccountOption.google => defaultWidget(SignInOptions.google, 'Google'),
      AccountOption.email => defaultWidget(Icons.email_outlined, 'Email'),
      AccountOption.none => null,
    };
  }
}
