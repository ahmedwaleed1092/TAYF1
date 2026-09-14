import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class SoilingTrendCard extends StatelessWidget {
  final List<double> values;
  final List<String> xLabels;

  const SoilingTrendCard({
    super.key,
    required this.values,
    required this.xLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.soilingCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Soiling Trend', style: AppStyle.soilingCardTitle),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: CustomPaint(
              size: Size.infinite,
              painter: _TrendPainter(values: values, xLabels: xLabels),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  final List<double> values;
  final List<String> xLabels;

  _TrendPainter({required this.values, required this.xLabels});

  @override
  void paint(Canvas canvas, Size size) {
    const leftPad = 30.0;
    const bottomPad = 20.0;
    final chartW = size.width - leftPad;
    final chartH = size.height - bottomPad;

    // Y axis grid + labels
    final gridPaint = Paint()
      ..color = AppColors.soilingGridLine
      ..strokeWidth = 1;
    final textStyle = TextStyle(
      color: AppColors.soilingAxisLabel,
      fontSize: 10,
    );
    for (final pct in [0.0, 0.10, 0.20]) {
      final y = chartH - (pct / 0.20) * chartH;
      canvas.drawLine(Offset(leftPad, y), Offset(size.width, y), gridPaint);
      final tp = TextPainter(
        text: TextSpan(text: '${(pct * 100).toInt()}%', style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - tp.height / 2));
    }

    // Line path
    final maxVal = 0.20;
    final path = Path();
    final points = <Offset>[];
    for (int i = 0; i < values.length; i++) {
      final x = leftPad + (i / (values.length - 1)) * chartW;
      final y = chartH - (values[i] / maxVal) * chartH;
      points.add(Offset(x, y));
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final linePaint = Paint()
      ..color = AppColors.soilingTrendLine
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = AppColors.soilingTrendLine;
    final dotBorder = Paint()..color = Colors.white;
    for (final p in points) {
      canvas.drawCircle(p, 4, dotBorder);
      canvas.drawCircle(p, 3, dotPaint);
    }

    // X labels
    for (int i = 0; i < xLabels.length; i++) {
      final x = leftPad + (i / (xLabels.length - 1)) * chartW;
      final tp = TextPainter(
        text: TextSpan(text: xLabels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, size.height - bottomPad + 4));
    }
  }

  @override
  bool shouldRepaint(covariant _TrendPainter oldDelegate) => true;
}
