import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PingIndicator extends StatelessWidget {
  final bool isHealthy;
  final int? latencyMs;
  final VoidCallback onPing;

  const PingIndicator({
    super.key,
    required this.isHealthy,
    this.latencyMs,
    required this.onPing,
  });

  @override
  Widget build(BuildContext context) {
    return PosCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.wifi_tethering,
                color: isHealthy ? AppColors.success : AppColors.error,
                size: 28,
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Real-Time Heartbeat Probe',
                    style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    latencyMs != null
                        ? 'Round-trip latency: ${latencyMs}ms'
                        : 'Checking server response...',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
          PosButton(
            label: 'Ping API',
            icon: Icons.refresh,
            variant: PosButtonVariant.outline,
            onPressed: onPing,
          ),
        ],
      ),
    );
  }
}
