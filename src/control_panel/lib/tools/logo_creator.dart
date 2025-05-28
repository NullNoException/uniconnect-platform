import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class LogoCreator {
  static Future<Uint8List> createLogo() async {
    const width = 400.0;
    const height = 400.0;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Background
    final bgPaint =
        Paint()
          ..color = const Color(0xFF2563EB)
          ..style = PaintingStyle.fill;

    canvas.drawCircle(
      const Offset(width / 2, height / 2),
      width / 2.2,
      bgPaint,
    );

    // Letter U
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'U',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 200,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (width - textPainter.width) / 2,
        (height - textPainter.height) / 2.2,
      ),
    );

    // Connect icon
    final connectPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(width / 2.5, height / 1.6),
      Offset(width / 1.5, height / 1.6),
      connectPaint,
    );

    // Convert to image
    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }
}
