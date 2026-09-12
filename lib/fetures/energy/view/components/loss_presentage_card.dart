import 'package:flutter/material.dart';

class LossItem {
  final String name;
  final double value; // بالـ kWh
  final double percent; // من 0 لـ 100
  final Color color;

  const LossItem({
    required this.name,
    required this.value,
    required this.percent,
    required this.color,
  });
}

class LossAttributionCard extends StatelessWidget {
  final List<LossItem> items;

  const LossAttributionCard({super.key, required this.items});

  static const Color titleColor = Color(0xFF16326B);
  static const Color valueColor = Color(0xFF4527A0);
  static const Color labelColor = Color(0xFF6B7280);

  LossItem get _topItem =>
      items.reduce((a, b) => a.percent >= b.percent ? a : b);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E6EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Loss Attribution',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _RingChart(items: items, topItem: _topItem),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: List.generate(items.length, (index) {
                    final isLast = index == items.length - 1;
                    return _LossListTile(
                      item: items[index],
                      showDivider: !isLast,
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingChart extends StatelessWidget {
  final List<LossItem> items;
  final LossItem topItem;

  const _RingChart({required this.items, required this.topItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(130, 130),
            painter: _RingPainter(items: items),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                topItem.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: LossAttributionCard.titleColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${topItem.value.toStringAsFixed(0)} KWh',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: LossAttributionCard.valueColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${topItem.percent.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: LossAttributionCard.valueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final List<LossItem> items;
  static const double strokeWidth = 12;

  _RingPainter({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    double startAngle = -3.1415926535 / 2; // يبدأ من فوق
    final total = items.fold<double>(0, (sum, i) => sum + i.percent);

    if (total == 0) {
      final paint = Paint()
        ..color = const Color(0xFFE3E6EC)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawCircle(center, radius, paint);
      return;
    }

    for (final item in items) {
      final sweepAngle = (item.percent / total) * 2 * 3.1415926535;
      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => true;
}

class _LossListTile extends StatelessWidget {
  final LossItem item;
  final bool showDivider;

  const _LossListTile({required this.item, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: LossAttributionCard.titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${item.value.toStringAsFixed(0)} KWh',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: LossAttributionCard.valueColor,
                ),
              ),
              Text(
                '${item.percent.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: LossAttributionCard.valueColor,
                ),
              ),
            ],
          ),
          if (showDivider) ...[
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFE3E6EC)),
          ],
        ],
      ),
    );
  }
}
