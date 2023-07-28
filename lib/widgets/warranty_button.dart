import 'package:flutter/material.dart';
import 'package:warranty_keeper/presentation/loading/widgets/triangle_loading_indicator.dart';

class WarrantyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final bool hasIcon;
  final Widget? widget;

  const WarrantyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isEnabled,
    required this.isLoading,
    this.widget,
  })  : hasIcon = false,
        super(key: key);

  const WarrantyElevatedButton.general({
    key,
    required this.onPressed,
    required this.text,
    required this.isEnabled,
  })  : isLoading = false,
        hasIcon = false,
        widget = null,
        super(key: key);

  const WarrantyElevatedButton.loading({
    key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
    required this.isEnabled,
  })  : hasIcon = false,
        widget = null,
        super(key: key);

  const WarrantyElevatedButton.iconLoading({
    key,
    required this.onPressed,
    required this.isLoading,
    required this.isEnabled,
    required this.widget,
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
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          child: isLoading
              ? Transform.scale(
                  scale: 0.5,
                  child: const TriangleLoadingIndicator(),
                )
              : hasIcon
                  ? widget
                  : Center(
                      child: Text(
                        text,
                      ),
                    ),
        ),
      ),
    );
  }
}
