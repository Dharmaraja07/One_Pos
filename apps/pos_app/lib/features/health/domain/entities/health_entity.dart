import 'package:equatable/equatable.dart';

class HealthEntity extends Equatable {
  final String status;
  final String databaseStatus;
  final String databaseProduct;
  final String version;
  final String environment;
  final DateTime timestamp;
  final int uptimeMillis;
  final Map<String, dynamic> details;

  const HealthEntity({
    required this.status,
    required this.databaseStatus,
    required this.databaseProduct,
    required this.version,
    required this.environment,
    required this.timestamp,
    required this.uptimeMillis,
    required this.details,
  });

  bool get isHealthy => status == 'UP' && databaseStatus == 'UP';

  @override
  List<Object?> get props => [
        status,
        databaseStatus,
        databaseProduct,
        version,
        environment,
        timestamp,
        uptimeMillis,
        details,
      ];
}
