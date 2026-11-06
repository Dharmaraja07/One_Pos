import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/health_entity.dart';

class SystemStatusCard extends StatelessWidget {
  final HealthEntity health;

  const SystemStatusCard({super.key, required this.health});

  @override
  Widget build(BuildContext context) {
    return PosCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spring Boot Modular Monolith',
                style: AppTypography.h3.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              StatusPill(
                label: health.status,
                type: health.status == 'UP' ? StatusType.success : StatusType.warning,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(),
          const SizedBox(height: AppSpacing.md),
          _buildInfoRow('Database Engine', health.databaseProduct),
          _buildInfoRow(
            'Database Connectivity',
            health.databaseStatus,
            badge: StatusPill(
              label: health.databaseStatus,
              type: health.databaseStatus == 'UP' ? StatusType.success : StatusType.error,
            ),
          ),
          _buildInfoRow('Platform Version', health.version),
          _buildInfoRow('Active Environment', health.environment),
          _buildInfoRow(
            'Uptime',
            '${(health.uptimeMillis / 1000).toStringAsFixed(1)} seconds',
          ),
          _buildInfoRow(
            'Server Timestamp (UTC)',
            health.timestamp.toIso8601String(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Widget? badge}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs + 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondaryLight),
          ),
          badge ??
              Text(
                value,
                style: AppTypography.mono.copyWith(fontWeight: FontWeight.w600),
              ),
        ],
      ),
    );
  }
}
