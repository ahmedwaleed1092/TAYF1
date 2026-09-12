import 'package:flutter/material.dart';

class TariffBreakdownWidget extends StatelessWidget {
  final String title;
  final String value;
  const TariffBreakdownWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4F4), // Light red background
            border: Border.all(
              color: const Color(0xFFFFDCE0),
            ), // Light red border
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error,
                color: Color(0xFFD32F2F), // Red error color
                size: 26,
              ),
              const SizedBox(width: 22),
              Expanded(
                child: Text(
                  'Calculation based on selected tariff\nscheme and current energy loss.',
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24), // Spacing between the two sections
        // Bottom Tariff Breakdown Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF3FC), // Light blue background
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title and Icon
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF173661), // Dark blue background for icon
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.priority_high,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF173661), // Dark blue text color
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Inner White Card (Data Row)
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  bottom: 12,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Color(0xFF718096), // Slate / Greyish blue
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '16,120 EGP',
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 1.5,
                      indent: 8,
                      endIndent: 8,
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 1.5,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
