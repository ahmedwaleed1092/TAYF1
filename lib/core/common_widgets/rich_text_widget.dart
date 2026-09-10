import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_style.dart';

class RichTextWidget extends StatelessWidget {
  final String mainText;
  final String subText;
  final Function? onTap;

  const RichTextWidget({
    super.key,
    required this.mainText,
    required this.subText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap as Function()?,

        child: RichText(
          text: TextSpan(
            text: mainText,
            style: AppStyle.gray10Regular.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children: [
              TextSpan(
                text: subText,
                style: AppStyle.gray10Regular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
