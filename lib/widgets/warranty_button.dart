import 'package:flutter/material.dart';

class WarrantyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final bool hasIcon;

  const WarrantyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isEnabled,
    required this.isLoading,
  })  : hasIcon = false,
        super(key: key);

  const WarrantyElevatedButton.general({
    key,
    required this.onPressed,
    required this.text,
    required this.isEnabled,
  })  : isLoading = false,
        hasIcon = false,
        super(key: key);

  const WarrantyElevatedButton.loading({
    key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
    required this.isEnabled,
  })  : hasIcon = false,
        super(key: key);

  const WarrantyElevatedButton.iconLoading({
    key,
    required this.onPressed,
    required this.isLoading,
    required this.isEnabled,
  })  : hasIcon = true,
        text = '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
        onPressed: isEnabled
            ? isLoading
                ? null
                : onPressed
            : null,
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : hasIcon
                ? Icon(Icons.circle)
                : Center(
                    child: Text(
                      text,
                    ),
                  ),
      ),
    );
  }
}
