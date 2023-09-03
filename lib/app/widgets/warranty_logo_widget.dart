import 'package:warranty_watch/app/app_library.dart';

class WarrantyLogo extends StatelessWidget {
  const WarrantyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CustomPaint(
      size: const Size(250, 125), // Adjust width and height as needed
      painter: OvalPainter(
        textColor: context.colorScheme.onPrimary,
        text: l10n.mainTitle.toUpperCase(),
        borderColor: context.colorScheme.onPrimary,
        background: context.colorScheme.primary,
      ),
    );
  }
}

class OvalPainter extends CustomPainter {
  OvalPainter({
    required this.borderColor,
    required this.background,
    required this.textColor,
    required this.text,
    super.repaint,
  });
  final Color borderColor;
  final Color background;
  final Color textColor;
  final String text;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = background // Oval background color
      ..style = PaintingStyle.fill;

    final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));

    // Draw an oval
    canvas.drawOval(rect, paint);

    final borderPaint = Paint()
      ..color = borderColor // Border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0; // Border width

    // Draw a border around the oval
    canvas.drawOval(rect, borderPaint);

    final textStyle = TextStyle(
      color: textColor,
      fontSize: 37.588035583496094,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      height: 0.8,
    );

    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: size.width,
      );

    final xOffset = (size.width - textPainter.width) / 2;
    final yOffset = (size.height - textPainter.height) / 1.59;

    final textOffset = Offset(xOffset, yOffset);

    // Draw the text in the center of the oval
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
