import 'package:equatable/equatable.dart';
import '../../domain/entities/health_entity.dart';

abstract class HealthState extends Equatable {
  const HealthState();

  @override
  List<Object?> get props => [];
}

class HealthInitial extends HealthState {
  const HealthInitial();
}

class HealthLoading extends HealthState {
  const HealthLoading();
}

class HealthLoaded extends HealthState {
  final HealthEntity health;
  final bool isPingHealthy;
  final int? pingLatencyMs;

  const HealthLoaded({
    required this.health,
    this.isPingHealthy = true,
    this.pingLatencyMs,
  });

  HealthLoaded copyWith({
    HealthEntity? health,
    bool? isPingHealthy,
    int? pingLatencyMs,
  }) {
    return HealthLoaded(
      health: health ?? this.health,
      isPingHealthy: isPingHealthy ?? this.isPingHealthy,
      pingLatencyMs: pingLatencyMs ?? this.pingLatencyMs,
    );
  }

  @override
  List<Object?> get props => [health, isPingHealthy, pingLatencyMs];
}

class HealthError extends HealthState {
  final String message;
  final String? code;

  const HealthError({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}
