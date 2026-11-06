import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';

enum StatusType { success, warning, error, info }

class StatusPill extends StatelessWidget {
  final String label;
  final StatusType type;

  const StatusPill({
    super.key,
    required this.label,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (type) {
      case StatusType.success:
        bg = AppColors.success.withOpacity(0.12);
        fg = AppColors.accentDark;
        break;
      case StatusType.warning:
        bg = AppColors.warning.withOpacity(0.15);
        fg = const Color(0xFFB45309);
        break;
      case StatusType.error:
        bg = AppColors.error.withOpacity(0.12);
        fg = const Color(0xFFB91C1C);
        break;
      case StatusType.info:
        bg = AppColors.info.withOpacity(0.12);
        fg = const Color(0xFF0369A1);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: fg,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.xs + 2),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
