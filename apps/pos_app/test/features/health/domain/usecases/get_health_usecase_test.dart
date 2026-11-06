import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos_app/features/health/domain/entities/health_entity.dart';
import 'package:pos_app/features/health/domain/repositories/health_repository.dart';
import 'package:pos_app/features/health/domain/usecases/get_health_usecase.dart';

class MockHealthRepository extends Mock implements HealthRepository {}

void main() {
  late GetHealthUseCase useCase;
  late MockHealthRepository mockRepository;

  setUp(() {
    mockRepository = MockHealthRepository();
    useCase = GetHealthUseCase(mockRepository);
  });

  final tHealth = HealthEntity(
    status: 'UP',
    databaseStatus: 'UP',
    databaseProduct: 'PostgreSQL 16.0',
    version: '1.0.0-phase1',
    environment: 'test',
    timestamp: DateTime.parse('2026-11-06T05:30:00Z'),
    uptimeMillis: 15000,
    details: const {'threads': 8},
  );

  test('should return HealthEntity from the repository', () async {
    when(() => mockRepository.getSystemHealth())
        .thenAnswer((_) async => tHealth);

    final result = await useCase();

    expect(result, equals(tHealth));
    expect(result.isHealthy, isTrue);
    verify(() => mockRepository.getSystemHealth()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
