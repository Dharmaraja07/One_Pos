import '../entities/health_entity.dart';
import '../repositories/health_repository.dart';

class GetHealthUseCase {
  final HealthRepository repository;

  GetHealthUseCase(this.repository);

  Future<HealthEntity> call() async {
    return await repository.getSystemHealth();
  }
}
