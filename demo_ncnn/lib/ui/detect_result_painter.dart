import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../store/yolox_store.dart';

class DetectResultPainter extends CustomPainter {
  Size? _size;
  List<YoloxObject>? _objects = [];

  void setImageSize(Size? size) {
    _size = size;
  }

  void setObjects(List<YoloxObject>? objects) {
    _objects = objects;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // implement paint
    if (_size == null || _objects == null) return;

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..isAntiAlias = true;

    const textStyle = TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.normal,
    );

    var scale = 1.0;
    var [w, h] = [_size!.width, _size!.height];
    if (w > size.width || h > size.height) {
      scale = min(size.width / w, size.height / h);
    }

    // var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // canvas.drawRect(rect, paint);

    for (var obj in _objects!) {
      var rect = obj.rect;
      canvas.drawRect(
          Rect.fromLTRB(rect.left * scale, rect.top * scale, rect.right * scale,
              rect.bottom * scale),
          paint);

      TextPainter(
        text: TextSpan(
          text:
              ' ${cocoLabels[obj.label]}: ${(obj.prob * 100).toStringAsFixed(2)}%',
          style: textStyle,
        ),
        textDirection: ui.TextDirection.ltr,
      )
        ..layout()
        ..paint(
          canvas,
          Offset(
            rect.left * scale,
            rect.top * scale,
          ),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
