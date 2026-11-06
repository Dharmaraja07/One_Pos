import '../../domain/entities/health_entity.dart';

class HealthModel extends HealthEntity {
  const HealthModel({
    required super.status,
    required super.databaseStatus,
    required super.databaseProduct,
    required super.version,
    required super.environment,
    required super.timestamp,
    required super.uptimeMillis,
    required super.details,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json) {
    return HealthModel(
      status: json['status'] as String? ?? 'UNKNOWN',
      databaseStatus: json['databaseStatus'] as String? ?? 'DOWN',
      databaseProduct: json['databaseProduct'] as String? ?? 'UNKNOWN',
      version: json['version'] as String? ?? 'UNKNOWN',
      environment: json['environment'] as String? ?? 'unknown',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
      uptimeMillis: (json['uptimeMillis'] as num?)?.toInt() ?? 0,
      details: json['details'] != null && json['details'] is Map
          ? Map<String, dynamic>.from(json['details'] as Map)
          : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'databaseStatus': databaseStatus,
      'databaseProduct': databaseProduct,
      'version': version,
      'environment': environment,
      'timestamp': timestamp.toIso8601String(),
      'uptimeMillis': uptimeMillis,
      'details': details,
    };
  }
}
