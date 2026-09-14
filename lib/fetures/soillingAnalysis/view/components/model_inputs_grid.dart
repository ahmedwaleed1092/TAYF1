import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class ModelInputsGrid extends StatelessWidget {
  final List<String> inputs;

  const ModelInputsGrid({super.key, required this.inputs});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 14,
      children: inputs.map((label) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 32 - 24) / 2,
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.soilingCheckGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 13),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label, style: AppStyle.soilingInputLabel),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
