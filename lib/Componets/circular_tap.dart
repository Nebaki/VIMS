import 'package:flutter/material.dart';

class CircleTabIndicator extends Decoration {
  final Color color;
  double rad;
  CircleTabIndicator({required this.color, required this.rad});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, rad: rad);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  double rad;
  CirclePainter({required this.color, required this.rad});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(configuration.size!.width / 2 - rad / 2,
        configuration.size!.height - rad);
    canvas.drawCircle(offset + circleOffset, rad, paint);
  }
}