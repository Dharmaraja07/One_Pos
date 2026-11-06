import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/health_bloc.dart';
import '../bloc/health_event.dart';
import '../bloc/health_state.dart';
import '../widgets/ping_indicator.dart';
import '../widgets/system_status_card.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universal POS — System Diagnostics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Status',
            onPressed: () {
              context.read<HealthBloc>().add(const FetchHealthEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthLoading) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    'Querying Universal POS backend...',
                    style: AppTypography.bodyMedium,
                  ),
                ],
              ),
            );
          }

          if (state is HealthError) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: PosCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 48,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Text(
                        'Backend Connection Failed',
                        style: AppTypography.h3,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      PosButton(
                        label: 'Retry Connection',
                        icon: Icons.refresh,
                        onPressed: () {
                          context.read<HealthBloc>().add(const FetchHealthEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is HealthLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HealthBloc>().add(const FetchHealthEvent());
              },
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    children: [
                      PingIndicator(
                        isHealthy: state.isPingHealthy,
                        latencyMs: state.pingLatencyMs,
                        onPing: () {
                          context.read<HealthBloc>().add(const PingServerEvent());
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      SystemStatusCard(health: state.health),
                      const SizedBox(height: AppSpacing.xl),
                      PosCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phase 1 Architecture Verification',
                              style: AppTypography.h3,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'End-to-end integration verified: Flutter POS Client communicating with Spring Boot Modular Monolith, Flyway DB migration engine, and PostgreSQL.',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
