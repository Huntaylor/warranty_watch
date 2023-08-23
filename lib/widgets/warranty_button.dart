import 'package:flutter/material.dart';
import 'package:warranty_keeper/presentation/loading/widgets/triangle_loading_indicator.dart';
import 'package:warranty_keeper/widgets/sign_in_options_icons.dart';

enum AccountOption { apple, google, email, none }

class WarrantyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final AccountOption accountOption;

  const WarrantyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isEnabled,
    required this.isLoading,
  })  : accountOption = AccountOption.none,
        super(key: key);

  const WarrantyElevatedButton.general({
    key,
    required this.onPressed,
    required this.text,
    required this.isEnabled,
  })  : isLoading = false,
        accountOption = AccountOption.none,
        super(key: key);

  const WarrantyElevatedButton.loading({
    key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
    required this.isEnabled,
  })  : accountOption = AccountOption.none,
        super(key: key);

  const WarrantyElevatedButton.signInOption(
      {key,
      required this.onPressed,
      required this.isLoading,
      required this.isEnabled,
      required this.accountOption})
      : text = '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
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
                    : _getOption(accountOption),
          ),
        ),
      ),
    );
  }

  _getOption(AccountOption accountOption) {
    defaultWidget(
      IconData icon,
      String name,
    ) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          Text('Continue with $name'),
          const SizedBox.shrink(),
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
