import 'package:flutter/material.dart';

class EnergyLossCard extends StatelessWidget {
  final String value;
  final String unit;
  final String percentChange;

  const EnergyLossCard({
    super.key,
    required this.value,
    required this.unit,
    required this.percentChange,
  });

  static const Color titleColor = Color(0xFF16326B);
  static const Color valueColor = Color(0xFF3B2FC9);
  static const Color negativeColor = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E6EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_rounded,
                color: Color(0xFFFFAB9E),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Energy Loss',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 80,
                height: 22,
                child: CustomPaint(
                  painter: _StepLinePainter(color: negativeColor),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                percentChange,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: negativeColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepLinePainter extends CustomPainter {
  final Color color;

  _StepLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final double baseY = size.height * 0.8;
    final double topY = size.height * 0.2;

    path.moveTo(0, baseY);
    path.lineTo(size.width * 0.45, baseY);
    path.lineTo(size.width * 0.6, topY);
    path.lineTo(size.width, topY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _StepLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
