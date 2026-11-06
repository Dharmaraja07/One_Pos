import 'package:core/core.dart';
import '../entities/health_entity.dart';

abstract class HealthRepository {
  Future<HealthEntity> getSystemHealth();
  Future<bool> pingServer();
}
