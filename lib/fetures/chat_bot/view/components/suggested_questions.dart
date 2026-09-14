import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class SuggestedQuestions extends StatelessWidget {
  final List<String> questions;
  final ValueChanged<String> onTap;

  const SuggestedQuestions({
    super.key,
    required this.questions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.chatPrimary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text('Suggested Question', style: AppStyle.chatSuggestedHeader),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: questions
                .map((q) => _SuggestedChip(
                      label: q,
                      onTap: () => onTap(q),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SuggestedChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _SuggestedChip({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.chatBotBubble,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_forward,
                size: 14,
                color: AppColors.chatPrimary,
              ),
              const SizedBox(width: 6),
              Text(label, style: AppStyle.chatSuggestedChip),
            ],
          ),
        ),
      ),
    );
  }
}
