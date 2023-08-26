// ignore_for_file: cascade_invocations

import 'dart:math' as math;

import 'package:flutter/material.dart';

class TriangleLoadingIndicator extends StatefulWidget {
  const TriangleLoadingIndicator({super.key, this.size = 40.0});
  final double size;

  @override
  TriangleLoadingIndicatorState createState() =>
      TriangleLoadingIndicatorState();
}

class TriangleLoadingIndicatorState extends State<TriangleLoadingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )
        ..addListener(() {
          setState(() {});
        })
        ..repeat(),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Transform.translate(
        offset: const Offset(0, 7),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, -widget.size / 4), // Top triangle position
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _VerticalTrianglePainter(
                    controller: _controllers[0],
                    color: Colors.yellow,
                    strokeWidth: 1,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                  -widget.size / 4,
                  widget.size / 4,
                ), // Left triangle position
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _VerticalTrianglePainter(
                    controller: _controllers[1],
                    color: Colors.yellow,
                    strokeWidth: 1,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                  widget.size / 4,
                  widget.size / 4,
                ), // Right triangle position
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _VerticalTrianglePainter(
                    controller: _controllers[2],
                    color: Colors.yellow,
                    strokeWidth: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerticalTrianglePainter extends CustomPainter {
  _VerticalTrianglePainter({
    required this.controller,
    required this.color,
    this.strokeWidth = 2.0,
  });
  final AnimationController controller;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.black // Set the border color to black
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final halfWidth = size.width / 2;
    final height = size.height;

    // Calculate the rotation angle with modulo to ensure continuity
    final rotationAngle = (controller.value * math.pi * 3) % (math.pi * 2);

    // Draw the triangle
    final path = Path();
    // final double triangleSize =
    //     halfWidth / 2; // Calculate the side length of the triangle
    // final double centerY = height / 2 +
    //     triangleSize / 2; // Calculate the center point on the y-axis
    path.moveTo(halfWidth, 0);
    path.lineTo(halfWidth - halfWidth / 2, height / 2);
    path.lineTo(halfWidth + halfWidth / 2, height / 2);
    path.close();

    // Apply rotation and perspective to the triangle
    final transformMatrix = Matrix4.identity()..rotateY(rotationAngle);

    canvas.save();
    canvas.translate(halfWidth, halfWidth);
    canvas.transform(transformMatrix.storage);
    canvas.translate(-halfWidth, -halfWidth);

    canvas.drawPath(path, fillPaint); // Draw the filled triangle
    canvas.drawPath(path, strokePaint); // Draw the triangle border
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
