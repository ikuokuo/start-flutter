import 'dart:math';

import 'package:flutter/material.dart';

class DetectResultPainter extends CustomPainter {
  Size? _size;
  List<Rect>? _bboxes;

  void setImageSize(Size? size) {
    _size = size;
  }

  void setBoundingBoxes(List<Rect>? bboxes) {
    _bboxes = bboxes;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // implement paint
    if (_size == null || _bboxes == null) return;

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..isAntiAlias = true;

    var scale = 1.0;
    var [w, h] = [_size!.width, _size!.height];
    if (w > size.width || h > size.height) {
      scale = min(size.width / w, size.height / h);
    }

    // var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // canvas.drawRect(rect, paint);

    for (var box in _bboxes!) {
      canvas.drawRect(
          Rect.fromLTRB(box.left * scale, box.top * scale, box.right * scale,
              box.bottom * scale),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // implement shouldRepaint
    // throw UnimplementedError();
    return false;
  }
}
