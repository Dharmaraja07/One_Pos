import '../repositories/health_repository.dart';

class PingUseCase {
  final HealthRepository repository;

  PingUseCase(this.repository);

  Future<bool> call() async {
    return await repository.pingServer();
  }
}
