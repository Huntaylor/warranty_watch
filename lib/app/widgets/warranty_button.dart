import 'package:flutter/material.dart';
import 'package:warranty_watch/app/presentation/loading/widgets/triangle_loading_indicator.dart';

class WarrantyElevatedButton extends StatelessWidget {
  const WarrantyElevatedButton({
    required this.onPressed,
    required this.text,
    required this.isEnabled,
    required this.isLoading,
    super.key,
    this.widget,
  }) : hasIcon = false;

  const WarrantyElevatedButton.general({
    required this.onPressed,
    required this.text,
    required this.isEnabled,
    super.key,
  })  : isLoading = false,
        hasIcon = false,
        widget = null;

  const WarrantyElevatedButton.loading({
    required this.onPressed,
    required this.text,
    required this.isLoading,
    required this.isEnabled,
    super.key,
  })  : hasIcon = false,
        widget = null;

  const WarrantyElevatedButton.iconLoading({
    required this.onPressed,
    required this.isLoading,
    required this.isEnabled,
    required this.widget,
    super.key,
  })  : hasIcon = true,
        text = '';
  final VoidCallback onPressed;
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final bool hasIcon;
  final Widget? widget;

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
                : hasIcon
                    ? widget
                    : Center(
                        child: Text(
                          text,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
