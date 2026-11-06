import 'package:core/core.dart';
import '../../domain/entities/health_entity.dart';
import '../../domain/repositories/health_repository.dart';
import '../datasources/health_remote_datasource.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthRemoteDataSource remoteDataSource;

  HealthRepositoryImpl(this.remoteDataSource);

  @override
  Future<HealthEntity> getSystemHealth() async {
    try {
      return await remoteDataSource.fetchHealth();
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<bool> pingServer() async {
    try {
      return await remoteDataSource.ping();
    } catch (_) {
      return false;
    }
  }
}
