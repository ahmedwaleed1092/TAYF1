import 'package:flutter/material.dart';

class SystemStatusBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color iconBackgroundColor;

  const SystemStatusBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.check_rounded,
    this.backgroundColor = const Color(0xFF0E4211),
    this.iconBackgroundColor = const Color(0xFF22C55E),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 16.0, weight: 700),
          ),

          const SizedBox(width: 8.0),

          // النصوص (Title & Subtitle)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
